extends LineEdit

func _enter_tree() -> void:
	TypingManager.connect_line_edit(self)
