extends Node

@onready var test_field_theme := preload("res://resource/test_field.tres")

enum SETTING_PRESET {
	DEFAULTS,
	CHANGED,
}

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

var current_settings: Dictionary[String, Dictionary] = DEFAULT_SETTINGS.duplicate(true)
var changed_settings: Dictionary[String, Dictionary] = current_settings.duplicate(true)

func apply_settings(preset: SETTING_PRESET = SETTING_PRESET.CHANGED) -> void:
	var temp: Dictionary[String, Dictionary] = DEFAULT_SETTINGS if preset == SETTING_PRESET.DEFAULTS else changed_settings
	
	# DISPLAY
	if temp.display.window_mode != current_settings.display.window_mode:
		DisplayServer.window_set_mode(temp.display.window_mode)
	
	if temp.display.resizable != current_settings.display.resizable:
		get_viewport().get_window().unresizable = !temp.display.resizable
	
	# GENERAL
	if (temp.general.font_size != current_settings.general.font_size) or (temp.general.font_scale != current_settings.general.font_scale):
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", roundi(temp.general.font_size * temp.general.font_scale))
	
	for node in get_tree().get_nodes_in_group(&"adjustable_displays"):
		if node.has_method(&"adjust_display"):
			node.adjust_display()
			print(&"Log: Node [" + node.name + &"] adjusted display.")
		else:
			printerr("Log Error: Node [" + str(node) + "] does not have adjust_display() method.")
	
	current_settings = temp.duplicate(true)
	print(&"Log: Current settings updated with changed settings.")
	
	# match selected items
	if preset == SETTING_PRESET.DEFAULTS:
		StateMachine.settings.visible = !StateMachine.settings.visible
		StateMachine.settings.visible = !StateMachine.settings.visible

func create_settings(file_path: String) -> void:
	var config := ConfigFile.new()
	
	for section_name in DEFAULT_SETTINGS:
		var section_data: Dictionary = DEFAULT_SETTINGS[section_name]
		for key in section_data:
			var value = section_data[key]
			config.set_value(section_name, key, value)
	
	var err := config.save(file_path)
	if err == OK:
		print("Settings created/saved successfully to: ", file_path)
	else:
		printerr("Failed to save settings: ", err)

func ensure_directory() -> String:
	var directory: String = OS.get_user_data_dir() + &"/config/"
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

func load_settings(file_path: String) -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var err := config.load(ensure_directory() + &"settings.cfg")
	var loaded_data : Dictionary[String, Dictionary]
	
	if err == OK:
		for section_name in config.get_sections():
			loaded_data[section_name] = {}
			for key in config.get_section_keys(section_name):
				var value = config.get_value(section_name, key)
				loaded_data[section_name][key] = value
	elif err == ERR_FILE_NOT_FOUND:
		printerr("Settings file not found at: ", file_path, ". Creating default settings.")
		create_settings(file_path)
		return DEFAULT_SETTINGS.duplicate(true)
	else:
		printerr("Failed to load settings file (Error: ", err, ") from: ", file_path)
		return DEFAULT_SETTINGS.duplicate(true)
	return loaded_data

func _ready() -> void:
	current_settings = load_settings(ensure_directory() + &"settings.cfg")
	print(current_settings)


#region dont remove
#
### creates the default theme of 'path'
#func create_theme(path: String) -> void:
	#if path.match(&"test_field.tres"):
		#var new_theme: Theme = Theme.new()
		#
		## margins
		#new_theme.set_constant(&"margin_left", &"MarginContainer", 5)
		#new_theme.set_constant(&"margin_right", &"MarginContainer", 5)
		#
		## font sizes
		#new_theme.set_font_size(&"font_size", &"Label", 30)
		#new_theme.set_font_size(&"font_size", &"LineEdit", 30)
		#new_theme.set_font_size(&"normal_font_size", &"RichTextLabel", 46)
		#new_theme.set_stylebox(&"panel", &"PanelContainer", StyleBoxEmpty.new())
		#
		#ResourceSaver.save(new_theme, ensure_directory() + path)
	#elif path.match(&"settings.tres"):
		#var new_theme: Theme = Theme.new()
		#
		## margins
		#new_theme.set_constant(&"margin_bottom", &"MarginContainer", 10)
		#new_theme.set_constant(&"margin_left", &"MarginContainer", 10)
		#new_theme.set_constant(&"margin_right", &"MarginContainer", 10)
		#new_theme.set_constant(&"margin_top", &"MarginContainer", 10)
		#
		## font sizes
		#new_theme.set_font_size(&"font_size", &"Label", 36)
		#new_theme.set_font_size(&"font_size", &"TabContainer", 36)
		#new_theme.set_font_size(&"font_size", &"Button", 30)
		#new_theme.set_font_size(&"font_size", &"CheckBox", 30)
		#new_theme.set_font_size(&"font_size", &"OptionButton", 30)
		#
		#ResourceSaver.save(new_theme, ensure_directory() + path)
	#elif path.match(&"wpm_panel.test"):
		#var new_theme: Theme = Theme.new()
		#
		## margins 
		#new_theme.set_constant(&"separation", &"HBoxContainer", 5)
		#new_theme.set_constant(&"margin_bottom", &"MarginContainer", 5)
		#new_theme.set_constant(&"margin_left", &"MarginContainer", 20)
		#new_theme.set_constant(&"margin_right", &"MarginContainer", 20)
		#new_theme.set_constant(&"margin_top", &"MarginContainer", 5)
		#
		## font sizes
		#new_theme.set_font_size(&"font_size", &"HeaderLarge", 100)
		#new_theme.set_font_size(&"font_size", &"HeaderSmall", 45)
		#new_theme.set_font_size(&"font_size", &"Label", 40)
		#
		#ResourceSaver.save(new_theme, ensure_directory() + path)
	#else:
		#printerr("Theme error")
#
#func load_themes() -> void:
	#const settings_path: String = &"settings.tres"
	#const test_field_path: String = &"test_field.tres"
	#const wpm_panel_path: String = &"wpm_panel.tres"
#endregion
