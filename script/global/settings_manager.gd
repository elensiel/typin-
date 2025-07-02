extends Node

const BASE_RESOLUTION := Vector2i(1920, 1080)
const DEFAULT_SETTINGS: Dictionary[String, Dictionary] = {
	"general" : {
		"font_size" : 46,
		"font_scale" : 1.0,
		"lines_shown" : 3,
	},
	"display" : {
		"window_mode" : DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED,
		"resizable" : true,
	},
	"keybindings" : {
		"restart_key" : InputManager.TAB,
		"restart_key_off" : true,
	},
}
var FILE_PATH: StringName = get_user_directory() + "settings.cfg"

var current_settings := load_settings()
var changed_settings := current_settings.duplicate(true)

func apply_settings(defaults: bool = false) -> void:
	var settings: Dictionary[String, Dictionary] = changed_settings if !defaults else DEFAULT_SETTINGS
	
	# DISPLAY
	# Window Mode
	if settings.display.window_mode != current_settings.display.window_mode:
		DisplayServer.window_set_mode(settings.display.window_mode)
	
	# Resizable
	if settings.display.resizable != current_settings.display.resizable:
		DisplayServer.window_set_mode(settings.display.resizable)
	
	# GENERAL
	# Font Size
	if settings.general.font_size != current_settings.general.font_size:
		var test_field_theme: Theme = NodeReferences.test_field_panel.theme
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", settings.general.font_size)
		ResourceSaver.save(test_field_theme, "res://resource/test_field_panel.tres")
	
	# Lines Shown
	if settings.general.lines_shown != current_settings.general.lines_shown:
		NodeReferences.test_field_panel.queue_redraw()
	
	# KEYBINDINGS
	if settings.keybindings.restart_key_off != current_settings.keybindings.restart_key_off:
		InputManager.restart_key_off = settings.keybindings.restart_key_off
		if InputManager.restart_key_off:
			NodeReferences.ui_container.restart_button.focus_mode = Button.FocusMode.FOCUS_ALL
		else:
			NodeReferences.ui_container.restart_button.focus_mode = Button.FocusMode.FOCUS_NONE
	
	if settings.keybindings.restart_key != current_settings.keybindings.restart_key:
		InputManager.restart_key = settings.keybindings.restart_test
	
	current_settings = settings.duplicate(true)
	
	if defaults:
		NodeReferences.settings_panel.update_selection()
	
	save_settings(settings)

## creates a new settings config file with DEFAULT_SETTINGS values
func create_new_settings() -> void:
	var config := ConfigFile.new()
	
	for section in DEFAULT_SETTINGS:
		var section_data: Dictionary = DEFAULT_SETTINGS[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(FILE_PATH)
	if error == OK:
		print("SettingsManager: Settings created successfully to: " + FILE_PATH)
	else:
		printerr("SettingsManager: Failed to save new settings file (Error: " + error_string(error) + ")")

## returns the user's data directory while ensuring it exists
func get_user_directory() -> StringName:
	var directory: String = OS.get_user_data_dir() + "/config/"
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

func load_settings() -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var error := config.load(FILE_PATH)
	
	if error == OK:
		var loaded_data : Dictionary[String, Dictionary]
		for section in config.get_sections():
			loaded_data[section] = {}
			for key in config.get_section_keys(section):
				loaded_data[section][key] = config.get_value(section, key)
		
		# append on size changes in DEFAULT_SETTINGS
		var has_new_settings: bool = false
		for section in DEFAULT_SETTINGS:
			if not loaded_data.has(section):
				loaded_data[section] = {}
			for key in DEFAULT_SETTINGS[section]:
				if not loaded_data[section].has(key):
					loaded_data[section][key] = DEFAULT_SETTINGS[section][key]
					has_new_settings = true
		
		if has_new_settings: 
			save_settings(loaded_data)
		
		return loaded_data
	else:
		printerr("SettingsManager: Failed to load settings (Error: " + error_string(error) + ")")
		if error == ERR_FILE_NOT_FOUND:
			create_new_settings()
	return DEFAULT_SETTINGS.duplicate(true)

func save_settings(settings: Dictionary[String, Dictionary]) -> void:
	var config := ConfigFile.new()
	
	for section in settings:
		var section_data: Dictionary = settings[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(FILE_PATH)
	if error == OK:
		print("SettingsManager: Settings saved successfully to: " + FILE_PATH)
	else:
		printerr("SettingsManager Error: Failed to save settings (Error: " + error_string(error) + &") to: " + FILE_PATH)
