extends MarginContainer
class_name SettingsPanel

var tab_buttons : Array[Button]
var tab_contents : Array[MarginContainer]
var window_mode : OptionButton
var resizable_buttons : Array[Button]
var quick_restart_buttons : Array[Button]

func _init() -> void:
	ObjectReferences.settings_panel = self
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 1.75
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / 1.75

func _enter_tree() -> void: print("Node: Setting up " + str(self))

func _ready() -> void:
	update_selection()
	tab_buttons[0].button_pressed = true

func update_selection() -> void:
	# GENERAL
	# Window Mode
	match DisplayServer.window_get_mode():
		DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
			window_mode.selected = 0
		DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED:
			window_mode.selected = 1
		DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
			window_mode.selected = 2
	
	# Window Resizable
	for button in resizable_buttons: button.disabled = window_mode.selected == 2
	resizable_buttons[0].button_pressed = SettingsManager.current_settings.general.resizable
	resizable_buttons[1].button_pressed = !SettingsManager.current_settings.general.resizable
	
	# quick restart button
	quick_restart_buttons[0].button_pressed = SettingsManager.current_settings.general.quick_restart_off
	if !quick_restart_buttons[0].button_pressed:
		match SettingsManager.current_settings.general.quick_restart:
			InputManager.ESC:
				quick_restart_buttons[1].button_pressed = true
			InputManager.TAB:
				quick_restart_buttons[2].button_pressed = true
			InputManager.ENTER:
				quick_restart_buttons[3].button_pressed = true
