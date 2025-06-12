extends Node
#class_name TextManager

var text_label : RichTextLabel

var current_text: Array[String] = []

func add_text() -> void:
	for i in range(10):
		current_text.append(Words.common_words.pick_random())

func randomize_text() -> void:
	# resets
	text_label.text = ""
	current_text.clear()
	
	for i in range(5):
		add_text()
	
	TypingManager.current_word = current_text[0]
	update()

func update() -> void:
	text_label.text = "" # reset
	for word in current_text:
		text_label.append_text(word + " ")

func scroll_update() -> void:
	pass
