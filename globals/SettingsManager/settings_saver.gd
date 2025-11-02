extends Node
class_name SettingsSaver

func save_data(file_path: String, defaults: bool = false) -> void:
	var config := ConfigFile.new()
	var settings_to_save: Dictionary[String, Dictionary]
	
	if defaults:
		settings_to_save = SettingsManager.DEFAULTS
	else:
		settings_to_save = SettingsManager.current_settings
	
	for section in settings_to_save:
		var section_data: Dictionary = settings_to_save[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(file_path)
	if error != OK:
		var error_msg := "SettingsManager Error: Failed to save settings (Error: %s) to: %s" % [error_string(error), file_path]
		return print_rich("[color=yellow]%s[/color]" % error_msg)
	
	return print("SettingsManager: Settings saved successfully to: " + file_path)
