extends RichTextLabel

func _enter_tree() -> void:
	text = WordManager.get_common_words()
