extends Node
class_name SettingsSaver

func save_data(file_path: String, defaults: bool = false) -> void:
	var config := ConfigFile.new()
	var settings_to_save: Dictionary[String, Dictionary]
	
	if defaults:
		settings_to_save = SettingsManager.DEFAULTS
	else:
		settings_to_save = SettingsManager.current_settings
		_clear_unused(settings_to_save)
	
	for section in settings_to_save:
		var section_data: Dictionary = settings_to_save[section]
		for key in section_data:
			config.set_value(section, key, section_data[key])
	
	var error := config.save(file_path)
	if error != OK:
		var error_msg := "SettingsSaver Error: Failed to save settings (Error: %s) to: %s" % [error_string(error), file_path]
		return print_rich("[color=yellow]%s[/color]" % error_msg)
	
	return print("SettingsSaver: Settings saved successfully to: " + file_path)

## Remove outdated or unused entries
func _clear_unused(data: Dictionary[String, Dictionary]) -> void:
	for section in data.keys():
		if not SettingsManager.DEFAULTS.has(section):
			data.erase(section)
			continue
		
		# cache
		var section_data: Dictionary = data[section]
		var default_section: Dictionary = SettingsManager.DEFAULTS[section]
		
		for key in section_data:
			if not default_section.has(key):
				section_data.erase(key)
