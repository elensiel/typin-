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
}
var FILE_PATH: StringName = ensure_directory() + &"settings.cfg"

var current_settings: Dictionary[String, Dictionary] = load_settings()
var changed_settings: Dictionary[String, Dictionary] = current_settings.duplicate(true)

func apply_settings(defaults: bool = false) -> void:
	var settings: Dictionary[String, Dictionary] = changed_settings if !defaults else DEFAULT_SETTINGS
	print(&"SettingsManager: Applying settings (defaults: " + str(defaults) + &").")
	
	# DISPLAY
	# Window Mode
	if settings.display.window_mode != current_settings.display.window_mode:
		DisplayServer.window_set_mode(settings.display.window_mode)
		print(&"SettingsManager: Window mode changed to " + str(settings.display.window_mode))
	
	# Resizable
	if settings.display.resizable != current_settings.display.resizable:
		get_viewport().get_window().unresizable = !settings.display.resizable
		print(&"SettingsManager: Resizable set to " + str(settings.display.window_mode))
	
	# MATCHING NODES' VISUALS
	for node in get_tree().get_nodes_in_group(&"adjustable_displays"):
		if node.has_method(&"adjust_display"):
			node.adjust_display()
			print(&"SettingsManager: Node [" + node.name + &"] adjusted display.")
		else:
			@warning_ignore_start("incompatible_ternary")
			printerr("SettingsManager Error: Node [" + str(node.name if is_instance_valid(node) else "INVALID_NODE") + "] (Path: " + str(node.get_path() if is_instance_valid(node) else "N/A") + ") in 'adjustable_displays' group does not have adjust_display() method.")
	
	current_settings = settings.duplicate(true)
	print(&"SettingsManager: Current settings updated after application.")
	
	# match selected items
	if defaults:
		StateMachine.settings.visible = !StateMachine.settings.visible
		StateMachine.settings.visible = !StateMachine.settings.visible
	
	save_settings(defaults)

func create_new_settings() -> void:
	print("SettingsManager: Creating new default settings file at: " + FILE_PATH)
	var config := ConfigFile.new()
	
	for section in DEFAULT_SETTINGS:
		var section_data: Dictionary = DEFAULT_SETTINGS[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(FILE_PATH)
	if error == OK:
		print("SettingsManager: Settings created/saved successfully to: " + FILE_PATH)
	else:
		printerr("SettingsManager Error: Failed to save new settings file (Error: " + error_string(error) + ") to: " + FILE_PATH)

func ensure_directory() -> StringName:
	var directory: String = OS.get_user_data_dir() + &"/config/"
	if !DirAccess.dir_exists_absolute(directory):
		var error = DirAccess.make_dir_absolute(directory)
		if error == OK:
			print("SettingsManager: Created settings directory: " + directory)
		else:
			printerr("SettingsManager Error: Failed to create settings directory (Error: " + error_string(error) + "): " + directory)
	return directory

func load_settings() -> Dictionary[String, Dictionary]:
	print("SettingsManager: Attempting to load settings from: " + FILE_PATH)
	var config := ConfigFile.new()
	var error := config.load(FILE_PATH)
	var loaded_data : Dictionary[String, Dictionary]
	
	if error == OK:
		print("SettingsManager: Settings file loaded successfully.")
		for section in config.get_sections():
			loaded_data[section] = {}
			for key in config.get_section_keys(section):
				loaded_data[section][key] = config.get_value(section, key)
	elif error == ERR_FILE_NOT_FOUND:
		printerr("SettingsManager Warning: Settings file not found at: " + FILE_PATH + ". Creating default settings.")
		create_new_settings()
		return DEFAULT_SETTINGS.duplicate(true)
	else:
		printerr("SettingsManager Error: Failed to load settings file (Error: " + error_string(error) + ") from: " + FILE_PATH + ". Returning default settings.")
		return DEFAULT_SETTINGS.duplicate(true)
	return loaded_data

func save_settings(defaults: bool = false) -> void:
	print(&"SettingsManager: Saving settings (defaults: " + str(defaults) + &") to: " + FILE_PATH)
	var config := ConfigFile.new()
	var settings: Dictionary[String, Dictionary] = changed_settings if !defaults else DEFAULT_SETTINGS
	
	for section in settings:
		var section_data: Dictionary = settings[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(FILE_PATH)
	if error == OK:
		print(&"SettingsManager: Settings saved successfully to: " + FILE_PATH)
	else:
		printerr("SettingsManager Error: Failed to save settings (Error: " + error_string(error) + &") to: " + FILE_PATH)
