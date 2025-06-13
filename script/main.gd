extends Control
class_name Main

func _ready() -> void:
	var line_edit: LineEdit = $CenterContainer/VBoxContainer/HBoxContainer/MarginContainer2/LineEdit
	TypingManager.connect_line_edit(line_edit)
	line_edit.grab_focus()
	
	var rtl: RichTextLabel = $CenterContainer/VBoxContainer/MarginContainer/RichTextLabel
	TextManager.text_label = rtl
	TextManager.randomize_text()
	
	var timer: Timer = $CenterContainer/VBoxContainer/HBoxContainer/MarginContainer/Timer
	GlobalTimer.connect_timer(timer)
	
	var timer_label: RichTextLabel = $CenterContainer/VBoxContainer/HBoxContainer/MarginContainer/TimerLabel
	GlobalTimer.connect_label(timer_label)
