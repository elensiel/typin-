extends Control
class_name Main

@onready var label: RichTextLabel = $CenterContainer/VBoxContainer/MarginContainer/RichTextLabel
@onready var line_edit: LineEdit = $CenterContainer/VBoxContainer/MarginContainer2/LineEdit

var current_text : Array[String]
var current_word : String
var pointer: int = 0

func _ready() -> void: 
	line_edit.grab_focus()
	randomize_text()
	current_word = current_text[pointer]

func evaluate_typing(word: String) -> void:
	if word.length() > current_word.length() || not word.match(current_word.substr(0, word.length())):
		pass
		current_text[pointer] = set_word_bgcolor(current_word, "darkred")
	else:
		pass
		current_text[pointer] = set_word_bgcolor(current_word, "dimgray")
	
	update()

func evaluate_word(word: String) -> void:
	if word == current_word:
		current_text[pointer] = "[color=seagreen]" + current_word + "[/color]"
	else:
		current_text[pointer] = "[color=darkred]" + current_word + "[/color]"
	
	update()

func randomize_text() -> void:
	label.text = "" # reset
	for i in range(50):
		current_text.append(Words.common_words.pick_random())
	update()

func set_word_bgcolor(word: String, color: String) -> String:
	return "[bgcolor=" + color + "]" + word + "[/bgcolor]"

func update() -> void:
	label.text = "" # reset
	for word in current_text:
		label.append_text(word + " ")

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.ends_with(" "):
		evaluate_word(new_text.trim_suffix(" "))
		pointer += 1
		current_word = current_text[pointer]
		line_edit.text = ""
	else:
		evaluate_typing(new_text)
