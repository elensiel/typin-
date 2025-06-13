extends Node
#class_name TextManager

var text_label : RichTextLabel

var current_text: Array[String] = []
var total_char: int = 0

func add_text() -> void:
	for i in range (50):
		var word: String = Words.common_words.pick_random()
		current_text.append(word)
		total_char += word.length() + 1

func randomize_text() -> void:
	# resets
	text_label.text = ""
	current_text.clear()
	
	add_text()
	
	TypingManager.current_word = current_text[0]
	update()

func update() -> void:
	text_label.text = "" # reset
	for word in current_text:
		text_label.append_text(word + " ")
	scroll_update()

func scroll_update() -> void:
	var current_line: int = text_label.get_character_line(TypingManager.current_char_idx)
	text_label.scroll_to_line(current_line - 1)
