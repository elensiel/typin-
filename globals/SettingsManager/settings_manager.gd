extends Node

var loader := SettingsLoader.new()
var saver := SettingsSaver.new()
var _file_path := _get_directory() + "/settings_data.cfg"

const DEFAULTS: Dictionary[String, Dictionary] = {
	"general" : {
		"shortcut_enabled" : false,
		"shortcut_key" : &"tab",
	},
	#"appearance" : {
		#"font" : null,
	#},
}

var current_settings: Dictionary[String, Dictionary] = loader.load_data(_file_path)

func _get_directory() -> String:
	var directory := OS.get_user_data_dir() + "/data"
	if not DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_recursive_absolute(directory)
	return directory

func save_changes() -> void:
	var has_changes := false
	
	if current_settings.general.shortcut_enabled != InputManager.shortcut_enabled:
		current_settings.general.shortcut_enabled = InputManager.shortcut_enabled
		has_changes = true
	
	if current_settings.general.shortcut_key != InputManager.shortcut_key:
		current_settings.general.shortcut_key = InputManager.shortcut_key
		has_changes = true
	
	if has_changes:
		saver.save_data(_file_path)
