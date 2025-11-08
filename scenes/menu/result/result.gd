extends Control
class_name ResultMenu

func _init() -> void:
	ObjectReferences.result_menu = self
	ThemeManager.themes[ThemeManager.Owner.RESULT] = theme
