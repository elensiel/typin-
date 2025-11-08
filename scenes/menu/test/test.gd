extends Control
class_name TestMenu

func _init() -> void:
	ObjectReferences.test_menu = self
	ThemeManager.themes[ThemeManager.Owner.TEST] = theme
