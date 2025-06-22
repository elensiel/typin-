extends Node

var line_edit : LineEdit

var ptr: int = 0
var cur_word : String
var cur_char_idx: int = 0
var cur_typed_len: int = 0

#region color values
# word submitted
var correct_word_color: String = "seagreen"
var wrong_word_color: String = "darkred"

# typing color
var correct_typed_color: String = "dimgray"
var wrong_typed_color: String = "darkred"
#endregion

func connect_line_edit(node: LineEdit) -> void:
	line_edit = node
	line_edit.connect("text_changed", Callable.create(self, "_on_line_edit_text_changed"))

#region evaluations
func _evaluate_typed(typed: String) -> void:
	var length: int = typed.length()
	
	if length > cur_word.length() or !cur_word.begins_with(typed):
		if length > cur_typed_len:
			ScoreManager.wrong_keystrokes += 1
		
		cur_typed_len = length
		TextManager.cur_text[ptr] = set_text_bgcolor(cur_word, wrong_typed_color)
	else:
		if length > cur_typed_len:
			ScoreManager.correct_keystrokes += 1
		
		cur_typed_len = length
		TextManager.cur_text[ptr] = set_text_bgcolor(cur_word, correct_typed_color)
	
	TextManager.update_text()

func _evaluate_word(word: String) -> void:
	if word == cur_word:
		#ScoreManager.correct_words += 1
		TextManager.cur_text[ptr] = set_text_color(cur_word, correct_word_color)
	else:
		#ScoreManager.wrong_words += 1
		TextManager.cur_text[ptr] = set_text_color(cur_word, wrong_word_color)
	
	TextManager.update_text()
	TextManager.scroll_update()
#endregion

func _next_word() -> void:
	# setters and resetters
	ptr += 1
	cur_char_idx += cur_word.length() + 1 # +1 for the whitespace
	cur_typed_len = 0
	line_edit.text = ""
	
	# add 50 more words on 70% completion
	if ptr > (TextManager.cur_text.size() * 0.70):
		TextManager.add_text()
	
	# text stuff
	cur_word = TextManager.cur_text[ptr]
	TextManager.cur_text[ptr] = set_text_bgcolor(cur_word, correct_typed_color)
	TextManager.update_text()
	TextManager.scroll_update()

func new_test() -> void:
	# value setters
	ptr = 0
	cur_word = TextManager.cur_text[ptr]
	cur_char_idx = 0
	cur_typed_len = 0
	
	# visual
	line_edit.text = ""
	TextManager.cur_text[ptr] = set_text_bgcolor(cur_word, correct_typed_color)
	
	#enable typing
	line_edit.editable = true
	line_edit.edit()

func stop_test() -> void:
	line_edit.editable = false

#region color setters
func set_text_color(word: String, color: String) -> String: 
	return "[color=" + color + "]" + word + "[/color]"

func set_text_bgcolor(word: String, color: String) -> String:
	return "[bgcolor=" + color + "]" + word + "[/bgcolor]"
#endregion

func _on_line_edit_text_changed(new_text: String) -> void:
	if StateMachine.cur_state != StateMachine.State.END and StateMachine.cur_state != StateMachine.State.TYPING:
		StateMachine.change_state(StateMachine.State.TYPING)
	
	if new_text.match(" "): # accidentally 'spaced'
		line_edit.text = ""
	elif new_text.ends_with(" "): # submit and eval
		_evaluate_word(new_text.trim_suffix(" "))
		_next_word()
	elif new_text.contains(" "): # bandaid for the not submitting bug
		var idx := new_text.find(" ")
		_evaluate_word(new_text.substr(0, idx))
		_next_word()
		line_edit.insert_text_at_caret(new_text.substr(idx + 1, new_text.length()))
	else: # visuals while typing
		_evaluate_typed(new_text)
	
	# cursor visibility
	if StateMachine.cur_state == StateMachine.State.TYPING:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
