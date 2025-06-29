extends Node

@onready var test_field_theme: Theme = preload("res://resource/test_field.tres")
var label : RichTextLabel
var cur_text : Array[String]

func connect_label(node: RichTextLabel) -> void: label = node

func add_text() -> void:
	var distance: int = 46 - ThemeManager.test_field.get_font_size(&"normal_font_size", &"RichTextLabel")
	var ratio: float = 1.0
	
	if distance < 46:
		ratio += (float(distance) / 46) * 2
	elif distance > 46:
		ratio -= float(distance) / 46
	
	for i in range(50 * ratio * SettingsManager.current_settings.general.lines_shown):
		var word: String = Words.common_words.pick_random()
		if cur_text.size() >= 1 && word.match(cur_text[cur_text.size() - 1]):
			continue
		else:
			cur_text.append(word)

func new_text() -> void:
	cur_text.clear()
	label.text = &""
	add_text()

func update_text() -> void:
	label.text = &""
	for word in cur_text:
		label.append_text(word + &" ")

func scroll_update() -> void:
	var cur_line:  int = label.get_character_line(TypingManager.cur_char_idx)
	label.scroll_to_line(cur_line - 1)
