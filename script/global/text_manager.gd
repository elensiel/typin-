extends Node
#class_name TextManager

var text_label : RichTextLabel

var current_text: Array[String] = []

func randomize_text() -> void:
	text_label.text = ""
	for i in range(50):
		current_text.append(Words.common_words.pick_random())
	TypingManager.current_word = current_text[0]
	update()

func update() -> void:
	text_label.text = "" # reset
	for word in current_text:
		text_label.append_text(word + " ")
