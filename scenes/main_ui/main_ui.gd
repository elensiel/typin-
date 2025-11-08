extends Control
class_name MainUI

func _init() -> void:
	ThemeManager.themes[ThemeManager.Owner.MAIN] = theme
