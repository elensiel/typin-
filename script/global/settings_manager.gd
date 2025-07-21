extends Node

const BASE_RESOLUTION := Vector2i(1920, 1080)
const DEFAULT_SETTINGS: Dictionary[String, Dictionary] = {
	"general" : {
		"window_mode" : DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED,
		"resizable" : true,
		"quick_restart" : InputManager.TAB,
		"quick_restart_active" : false,
	},
	"appearance" : {
		"font" : null,
		"font_size" : 46,
		"visible_lines" : 3,
		"visible_typing_field" : true,
	},
	#"color_scheme" : {
		#"background" : null,
		#"main_text" : null,
		#"outline_selection" : null,
		#"typed_correct" : &"dimgray",
		#"typed_error" : &"darkred",
		#"submit_correct" : &"seagreen",
		#"submit_error" : &"darkred",
	#},
	#"qol" : {
		#"settings_last_tab_opened" : 0,
	#},
}
var FILE_PATH: String = _get_user_directory() + "settings.cfg"

var current_settings := _load_settings()

## returns the user's data directory while ensuring it exists
func _get_user_directory() -> StringName:
	var directory: String = OS.get_user_data_dir() + "/config/"
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

## Loads settings from 'FILE_PATH'
func _load_settings() -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var error := config.load(FILE_PATH)
	
	if error == OK:
		var loaded_data : Dictionary[String, Dictionary]
		for section in config.get_sections():
			loaded_data[section] = {}
			for key in config.get_section_keys(section):
				loaded_data[section][key] = config.get_value(section, key)
		
		var synced_data = _add_missing_settings(loaded_data)
		if synced_data.has_changes: 
			current_settings = synced_data.data
			save_settings()
		return synced_data.data
	else:
		printerr("SettingsManager: Failed to load settings (Error: " + error_string(error) + ")")
		if error == ERR_FILE_NOT_FOUND:
			_create_new_settings()
		return DEFAULT_SETTINGS.duplicate(true)

func save_settings(defaults: bool = false) -> void:
	var config := ConfigFile.new()
	var final_settings: Dictionary[String, Dictionary]
	
	if defaults:
		final_settings = DEFAULT_SETTINGS.duplicate(true)
	else:
		final_settings = current_settings.duplicate(true)
		_clean_settings(final_settings)
	
	for section in final_settings:
		var section_data: Dictionary = final_settings[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
			
	var error := config.save(FILE_PATH)
	if error == OK:
		print("SettingsManager: Settings saved successfully to: " + FILE_PATH)
		return
	printerr("SettingsManager Error: Failed to save settings (Error: " + error_string(error) + ") to: " + FILE_PATH)

## creates a new settings config file with DEFAULT_SETTINGS values
func _create_new_settings() -> void:
	var config := ConfigFile.new()
	
	for section in DEFAULT_SETTINGS:
		var section_data: Dictionary = DEFAULT_SETTINGS[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(FILE_PATH)
	if error == OK:
		return print("SettingsManager: Settings created successfully to: " + FILE_PATH)
	printerr("SettingsManager: Failed to save new settings file (Error: " + error_string(error) + ")")

## Adds settings that do not exist in the loaded config from the DEFAULT_SETTINGS
func _add_missing_settings(loaded_data: Dictionary[String, Dictionary]) -> Dictionary:
	var has_changes: bool = false
	
	for section in DEFAULT_SETTINGS:
		if not loaded_data.has(section):
			loaded_data[section] = {}
			has_changes = true
		for key in DEFAULT_SETTINGS[section]:
			if not loaded_data[section].has(key):
				loaded_data[section][key] = DEFAULT_SETTINGS[section][key]
				has_changes = true
	
	return { "data": loaded_data, "has_changes": has_changes }

## Removes settings from the provided dictionary that are not present in the DEFAULTS_SETTINGS
func _clean_settings(settings: Dictionary[String, Dictionary]) -> void:
	# --- Deletion Logic for sections ---
	var sections_to_delete: Array = []
	for section in settings:
		if not DEFAULT_SETTINGS.has(section):
			sections_to_delete.append(section)
		else:
			# --- Deletion Logic for keys within sections ---
			var keys_to_delete: Array = []
			for key in settings[section]:
				if not DEFAULT_SETTINGS[section].has(key):
					keys_to_delete.append(key)
			
			for key in keys_to_delete:
				settings[section].erase(key)
				
	for section in sections_to_delete:
		settings.erase(section)
