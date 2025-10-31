extends Node

@onready var word_evaluator := WordEvaluator.new()
var line_edit: LineEdit

var current_char_index: int = 0
var current_word: String
var pointer: int = 0

func connect_line_edit(node: LineEdit) -> void:
	print("TypingManager: Connecting " + str(node))
	line_edit = node
	line_edit.connect(&"text_changed", Callable.create(self, &"_on_line_edit_text_changed"))

func new_test() -> void:
	pointer = 0
	current_char_index = 0
	current_word = TextManager.current_text[pointer]
	
	line_edit.text = &""
	line_edit.grab_focus()

func next_word() -> void:
	line_edit.text = &""
	current_char_index += current_word.length() + 1 # +1 for the whitespace
	
	# add more words on 50% completion
	if pointer > (TextManager.current_text.size() * 0.5): TextManager.add_text()
	
	pointer += 1
	current_word = TextManager.current_text[pointer]
	TextManager.render_on_type(pointer)
	TextManager.scroll_update()

func _on_line_edit_text_changed(new_text: String) -> void:
	# early exit on accidental 'space'
	if new_text.match(&" "):
		line_edit.text = &""
		return
	
	# change state
	if StateMachine.current_state != StateMachine.State.TYPING:
		StateMachine.change_state(StateMachine.State.TYPING)
	
	# submit and evaluate
	if new_text.ends_with(&" "):
		var is_correct := word_evaluator.is_word_correct(new_text.trim_suffix(&" "), current_word)
		TextManager.render_on_submit(pointer, is_correct)
		next_word()
	# bandaid for the not submitting if typed too fast bug
	elif new_text.contains(&" "):
		var index := new_text.find(&" ")
		var is_correct := word_evaluator.is_word_correct(new_text.substr(0, index), current_word)
		TextManager.render_on_submit(pointer, is_correct)
		next_word()
		line_edit.insert_text_at_caret(new_text.substr(index + 1, new_text.length()))
	# typing the word still
	else:
		TextManager.render_on_type(pointer, word_evaluator.is_typed_correct(new_text, current_word))
