extends Label

func _enter_tree() -> void:
	TimerManager.connect_label(self)
