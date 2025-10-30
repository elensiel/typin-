extends Node

@onready var tag_helper := TagHelper.new()
var label: RichTextLabel

var current_text: Array[String] = []

func connect_label(node: RichTextLabel) -> void: 
	print("TextManager: Connecting RichTextLabel: " + str(node))
	label = node

func add_text() -> void:
	var target_size := _get_target_size()
	print(&"TextMananger: Adding " + str(target_size - current_text.size()) + &" text")
	
	while current_text.size() <= target_size:
		var word: String = Words.EASY.pick_random()
		if current_text.size() >= 1 && word.match(current_text[current_text.size() - 1]):
			continue # avoid sequential repeated words
		current_text.append(word)

func _get_target_size() -> int:
	var initial_size := current_text.size()
	
	# size baseline
	var minimum_font_size: int = 30
	var current_font_size: int = 46 # TODO relative to current settings
	
	# modifier
	var distance: int = current_font_size - minimum_font_size
	var modifier: int = 5 + roundi(float(distance) / 5)
	
	return initial_size + ((minimum_font_size - modifier) * 6)

func new_text() -> void:
	print(&"TextMananger: Clearing text")
	current_text.clear()
	label.text = &""
	add_text()

func render_text(index: int = 0, correct: bool = true) -> void:
	label.text = &""
	
	if correct:
		current_text[index] = tag_helper.draw_background_correct(TypingManager.current_word)
	else:
		current_text[index] = tag_helper.draw_background_typo(TypingManager.current_word)
	
	for word in current_text:
		label.append_text(word + &" ")
