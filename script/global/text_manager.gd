extends Node

var label : RichTextLabel
var current_text : Array[String]

func connect_label(node: RichTextLabel) -> void: label = node

func add_text() -> void:
	var initial_size: int = current_text.size()
	
	var minimum_font_size: int = 30
	var current_font_size: int = SettingsManager.current_settings.general.font_size
	var distance: int = current_font_size - minimum_font_size
	var modifier: int = 5 + roundi(float(distance) / 5)
	
	var total: int = initial_size + ((minimum_font_size - modifier) * 6)
	print(&"TextMananger: Adding " + str(total - current_text.size()) + &" text")
	
	while current_text.size() <= total:
		var word: String = Words.common_words.pick_random()
		if current_text.size() >= 1 && word.match(current_text[current_text.size() - 1]):
			# avoid repeated words
			continue
		current_text.append(word)

func new_text() -> void:
	print(&"TextMananger: Clearing text")
	current_text.clear()
	label.text = &""
	add_text()

func update_text() -> void:
	label.text = &""
	for word in current_text:
		label.append_text(word + &" ")

func scroll_update() -> void:
	var cur_line: int = label.get_character_line(TypingManager.cur_char_idx)
	
	if SettingsManager.current_settings.general.lines_shown >= 2:
		label.scroll_to_line(cur_line - 1) # -1 for the whitespace
	else:
		label.scroll_to_line(cur_line)
