extends Node

const BASE_RESOLUTION := Vector2i(1920, 1080)
const DEFAULT_SETTINGS: Dictionary[String, Dictionary] = {
	"general" : {
		"window_mode" : DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED,
		"resizable" : true,
		"quick_restart" : InputManager.TAB,
		"quick_restart_off" : true,
	},
	"appearance" : {
		"font" : null,
		"font_size" : 46,
		"visible_lines" : 3,
	},
	"theme" : {
		
	},
	"qol" : {
		"settings_last_tab_opened" : 0,
	},
}
var FILE_PATH: StringName = get_user_directory() + "settings.cfg"

var current_settings := load_settings()
var changed_settings := current_settings.duplicate(true)

func apply_settings(defaults: bool = false) -> void:
	var settings: Dictionary[String, Dictionary] = changed_settings if !defaults else DEFAULT_SETTINGS
	
	# DISPLAY
	# Window Mode
	if settings.general.window_mode != current_settings.general.window_mode:
		DisplayServer.window_set_mode(settings.general.window_mode)
	
	# Resizable
	if settings.general.resizable != current_settings.general.resizable:
		DisplayServer.window_set_mode(settings.general.resizable)
	
	# GENERAL
	# Font & Font Size
	if (settings.appearance.font != current_settings.appearance.font) || (settings.appearance.font_size != current_settings.appearance.font_size):
		ThemeManager.update_theme(defaults)
	
	# Lines Shown
	if settings.appearance.visible_lines != current_settings.appearance.visible_lines:
		ObjectReferences.test_field_panel.queue_redraw()
	
	# KEYBINDINGS
	if settings.general.quick_restart_off != current_settings.general.quick_restart_off:
		InputManager.restart_key_off = settings.general.quick_restart_off
		if InputManager.restart_key_off:
			ObjectReferences.restart_test_button.focus_mode = Button.FocusMode.FOCUS_ALL
		else:
			ObjectReferences.restart_test_button.focus_mode = Button.FocusMode.FOCUS_NONE
	
	if settings.general.quick_restart != current_settings.general.quick_restart:
		InputManager.restart_key = settings.general.restart_key
	
	current_settings = settings.duplicate(true)
	
	if defaults:
		ObjectReferences.settings_panel.update_selection()
	
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
		return print("SettingsManager: Settings created successfully to: " + FILE_PATH)
	printerr("SettingsManager: Failed to save new settings file (Error: " + error_string(error) + ")")

## returns the user's data directory while ensuring it exists
func get_user_directory() -> StringName:
	var directory: String = OS.get_user_data_dir() + "/config/"
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

## loads settings from 'FILE_PATH'
func load_settings() -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var error := config.load(FILE_PATH)
	
	if error == OK:
		var loaded_data : Dictionary[String, Dictionary]
		for section in config.get_sections():
			loaded_data[section] = {}
			for key in config.get_section_keys(section):
				loaded_data[section][key] = config.get_value(section, key)
		
		var synced_result = sync_settings(loaded_data)
		if synced_result.has_changes: 
			save_settings(synced_result.data)
		return synced_result.data
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
		return print("SettingsManager: Settings saved successfully to: " + FILE_PATH)
	printerr("SettingsManager Error: Failed to save settings (Error: " + error_string(error) + &") to: " + FILE_PATH)

## add settings that does not exist on the current config and delete that are not present in the defaults
func sync_settings(loaded_data: Dictionary[String, Dictionary]) -> Dictionary:
	var has_changes: bool = false

	# --- Deletion Logic ---
	var sections_to_delete: Array = []
	for section in loaded_data:
		if not DEFAULT_SETTINGS.has(section):
			sections_to_delete.append(section)
			has_changes = true
		else:
			var keys_to_delete: Array = []
			for key in loaded_data[section]:
				if not DEFAULT_SETTINGS[section].has(key):
					keys_to_delete.append(key)
					has_changes = true
			
			for key in keys_to_delete:
				loaded_data[section].erase(key)
	for section in sections_to_delete:
		loaded_data.erase(section)

	# --- Addition/Update Logic ---
	for section in DEFAULT_SETTINGS:
		if not loaded_data.has(section):
			loaded_data[section] = {}
			has_changes = true
		for key in DEFAULT_SETTINGS[section]:
			if not loaded_data[section].has(key):
				loaded_data[section][key] = DEFAULT_SETTINGS[section][key]
				has_changes = true

	return { "data": loaded_data, "has_changes": has_changes }
