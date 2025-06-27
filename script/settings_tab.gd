extends TabContainer

@onready var font_size: OptionButton = $General/VBoxContainer/FontSize/OptionButton
@onready var window_mode: OptionButton = $Display/VBoxContainer/WindowMode/OptionButton
@onready var resizable: CheckBox = $Display/VBoxContainer/Resizable/CheckBox
@onready var lines_shown: OptionButton = $General/VBoxContainer/LinesShown/OptionButton
@onready var font_scale: OptionButton = $General/VBoxContainer/FontScale/OptionButton

func _on_visibility_changed() -> void:
	if owner.visible:
		# GENERAL
		# Font Size
		font_size.selected = (SettingsManager.current_settings.general.font_size - 30) / 2
		
		# Font Scale
		font_scale.selected = roundi(5.0 - (10.0 * (1.0 - SettingsManager.current_settings.general.font_scale)))
		
		# Lines Shown
		lines_shown.selected = SettingsManager.current_settings.general.lines_shown - 1
		
		# DISPLAY
		# Window Mode
		match DisplayServer.window_get_mode():
			DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
				window_mode.select(0)
			DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED:
				window_mode.select(1)
			DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
				window_mode.select(2)
		
		# Resizable
		resizable.button_pressed = SettingsManager.current_settings.display.resizable
