extends Node
#class_name TypingManager

var input : LineEdit

var pointer: int = 0
var current_word : String
var current_char_idx: int = 0

func connect_line_edit(node: LineEdit) -> void:
	input = node
	input.connect("text_changed", Callable.create(self, "_on_input_text_changed"))

func evaluate_typed(typed: String) -> void:
	if typed.length() > current_word.length() or !current_word.begins_with(typed):
		TextManager.current_text[pointer] = set_text_bgcolor(current_word, "darkred")
	else:
		TextManager.current_text[pointer] = set_text_bgcolor(current_word, "dimgray")
	
	TextManager.update()

func evaluate_word(word: String) -> void:
	if word == current_word:
		TextManager.current_text[pointer] = set_text_color(current_word, "seagreen")
	else:
		TextManager.current_text[pointer] = set_text_color(current_word, "darkred")
	
	TextManager.update()

func next_word() -> void:
	pointer += 1
	current_char_idx += current_word.length() + 1
	
	if pointer > TextManager.current_text.size() / 2:
		TextManager.add_text()
	
	current_word = TextManager.current_text[pointer]
	TextManager.current_text[pointer] = set_text_bgcolor(current_word, "dimgray")
	
	input.text = ""
	TextManager.update()
	
	TextManager.scroll_update()

func set_text_color(word: String, color: String) -> String:
	return "[color=" + color + "]" + word + "[/color]"

func set_text_bgcolor(word: String, color: String) -> String:
	return "[bgcolor=" + color + "]" + word + "[/bgcolor]"

func _on_input_text_changed(new_text: String) -> void:
	if new_text.ends_with(" "):
		evaluate_word(new_text.trim_suffix(" "))
		next_word()
	else:
		evaluate_typed(new_text)
