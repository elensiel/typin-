extends RichTextLabel

func _enter_tree() -> void:
	var words: Array[String] = WordManager.get_common_words()
	
	text = ""
	for word in words:
		text += word + " "
