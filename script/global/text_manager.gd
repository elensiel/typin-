extends Node

var label : RichTextLabel
var current_text : Array[String]
var current_word_source : Array = SettingsManager.current_settings.general.difficulty

func connect_label(node: RichTextLabel) -> void: 
	print("TextManager: Connecting RichTextLabel: " + str(node))
	label = node

func add_text() -> void:
	var total_size := _get_target_total_size()
	print(&"TextMananger: Adding " + str(total_size - current_text.size()) + &" text")
	
	while current_text.size() <= total_size:
		var word: String = current_word_source.pick_random()
		if current_text.size() >= 1 && word.match(current_text[current_text.size() - 1]):
			continue # avoid sequential repeated words
		current_text.append(word)

func _get_target_total_size() -> int:
	var initial_size: int = current_text.size()
	
	# size baseline
	var minimum_font_size: int = 30
	var current_font_size: int = SettingsManager.current_settings.appearance.font_size
	
	# modifier
	var distance: int = current_font_size - minimum_font_size
	var modifier: int = 5 + roundi(float(distance) / 5)
	
	return initial_size + ((minimum_font_size - modifier) * 6)

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
	var cur_line: int = label.get_character_line(TypingManager.current_char_index)
	
	if SettingsManager.current_settings.appearance.visible_lines >= 3:
		cur_line -= 1 # for whitespace
	
	label.scroll_to_line(cur_line)
