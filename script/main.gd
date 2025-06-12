extends Control
class_name Main

func _ready() -> void:
	var line_edit: LineEdit = $CenterContainer/VBoxContainer/MarginContainer2/LineEdit
	TypingManager.connect_line_edit(line_edit)
	line_edit.grab_focus()
	
	var rtl := $CenterContainer/VBoxContainer/MarginContainer/RichTextLabel
	TextManager.text_label = rtl
	TextManager.randomize_text()
