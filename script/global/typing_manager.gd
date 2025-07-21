extends Node

var line_edit : LineEdit

#region color values
const correct_typed_color := &"dimgray"
const error_typed_color := &"darkred"
const correct_word_color := &"seagreen"
const error_word_color := &"darkred"
#var correct_typed_color: StringName = SettingsManager.current_settings.color_scheme.typed_correct
#var error_typed_color: StringName = SettingsManager.current_settings.color_scheme.typed_error
#var correct_word_color: StringName = SettingsManager.current_settings.color_scheme.submit_correct
#var error_word_color: StringName = SettingsManager.current_settings.color_scheme.submit_error
#endregion

var _pointer: int = 0
var _current_word : String
var _current_typed_length: int = 0
var current_char_index: int = 0

func connect_line_edit(node: LineEdit) -> void:
	print("TypingManager: Connecting " + str(node))
	line_edit = node
	line_edit.connect("text_changed", Callable.create(self, "_on_line_edit_text_changed"))

#region typed/word evaluator methods
func _evaluate_typed(typed: String) -> void:
	var length: int = typed.length()
	
	if length > _current_word.length() or !_current_word.begins_with(typed):
		if length > _current_typed_length: ScoreManager.wrong_keystrokes += 1
		TextManager.current_text[_pointer] = _set_text_bgcolor(_current_word, error_typed_color)
	else:
		if length > _current_typed_length: ScoreManager.correct_keystrokes += 1
		TextManager.current_text[_pointer] = _set_text_bgcolor(_current_word, correct_typed_color)
	
	_current_typed_length = length
	TextManager.update_text()

func _evaluate_word(word: String) -> void:
	if word == _current_word:
		TextManager.current_text[_pointer] = _set_text_color(_current_word, correct_word_color)
	else:
		TextManager.current_text[_pointer] = _set_text_color(_current_word, error_word_color)
#endregion

func _next_word() -> void:
	# setters and resetters
	
	current_char_index += _current_word.length() + 1 # +1 for the whitespace
	_current_typed_length = 0
	line_edit.text = &""
	
	# add more words on 50% completion
	if _pointer > (TextManager.current_text.size() * 0.5): TextManager.add_text()
	
	# text stuff
	_pointer += 1
	_current_word = TextManager.current_text[_pointer]
	TextManager.current_text[_pointer] = _set_text_bgcolor(_current_word, correct_typed_color)
	TextManager.update_text()
	TextManager.scroll_update()

func new_test() -> void:
	# value setters
	_pointer = 0
	_current_word = TextManager.current_text[_pointer]
	current_char_index = 0
	_current_typed_length = 0
	
	# visual
	line_edit.text = &""
	TextManager.current_text[_pointer] = _set_text_bgcolor(_current_word, correct_typed_color)
	
	#enable typing
	#line_edit.editable = true
	line_edit.edit()

#region color setters
func _set_text_color(word: String, color: String) -> String: 
	return &"[color=" + color + &"]" + word + &"[/color]"

func _set_text_bgcolor(word: String, color: String) -> String:
	return &"[bgcolor=" + color + &"]" + word + &"[/bgcolor]"
#endregion

func _on_line_edit_text_changed(new_text: String) -> void:
	# early exit on accidental 'space'
	if new_text.match(&" "):
		line_edit.text = &""
		return
	
	# change state
	if StateMachine.current_state != StateMachine.State.TYPING:
		StateMachine.change_state(StateMachine.State.TYPING)
	
	# evaluation
	if new_text.ends_with(&" "): # submit and eval
		_evaluate_word(new_text.trim_suffix(&" "))
		_next_word()
	elif new_text.contains(&" "): # bandaid for the not submitting bug
		var index := new_text.find(&" ")
		_evaluate_word(new_text.substr(0, index))
		_next_word()
		line_edit.insert_text_at_caret(new_text.substr(index + 1, new_text.length()))
	else: # visuals while typing
		_evaluate_typed(new_text)
	
	# hide cursor
	if StateMachine.current_state == StateMachine.State.TYPING:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
