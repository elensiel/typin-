extends PanelContainer
class_name SettingsPanel

var font_buttons : Array[Button]
var font_size
var font_scale
var lines_shown
var window_mode
var resizable
var restart_buttons : Array[Button]

func _init() -> void: 
	ObjectReferences.settings_panel = self
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 1.75
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / 1.75

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))
	
	var tab_container := $MarginContainer/VBoxContainer/TabContainer
	tab_container.get_child(SettingsManager.current_settings.qol.settings_last_tab_opened).visible = true

## match selected items to current settings
func _ready() -> void: update_selection()

## revert changed settings to current settings
func _exit_tree() -> void:
	for tab in $MarginContainer/VBoxContainer/TabContainer.get_children():
		if tab.visible:
			SettingsManager.current_settings.qol.settings_last_tab_opened = tab.get_index()
			break
	
	SettingsManager.changed_settings = SettingsManager.current_settings.duplicate(true)

## updates button selected items
func update_selection() -> void:
	# GENERAL
	# Font
	font_buttons[0].button_pressed = true
	for button in font_buttons:
		var current_font := ObjectReferences.test_field_panel.theme.get_font(&"normal_font", &"RichTextLabel")
		if current_font == button.get_theme_font(&"font"):
			button.button_pressed = true
			break
	
	font_size.selected = (SettingsManager.current_settings.appearance.font_size - 30) / 2
	lines_shown.selected = SettingsManager.current_settings.appearance.visible_lines - 1
	
	# DISPLAY
	# Window Mode
	match DisplayServer.window_get_mode():
		DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
			window_mode.selected = 0
		DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED:
			window_mode.selected = 1
		DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
			window_mode.selected = 2
	resizable.button_pressed = SettingsManager.current_settings.general.resizable
	
	# KEYBINDINGS
	if SettingsManager.current_settings.general.quick_restart_off:
		restart_buttons[0].button_pressed = true
	else:
		match SettingsManager.current_settings.general.quick_restart:
			InputManager.ESC:
				restart_buttons[1].button_pressed = true
			InputManager.TAB:
				restart_buttons[2].button_pressed = true
			InputManager.ENTER:
				restart_buttons[3].button_pressed = true
