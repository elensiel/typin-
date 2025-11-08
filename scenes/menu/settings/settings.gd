extends Control
class_name SettingsMenu

func _init() -> void:
	ObjectReferences.settings_menu = self
	ThemeManager.themes[ThemeManager.Owner.SETTINGS] = theme
