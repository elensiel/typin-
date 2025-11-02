extends Node
class_name SettingsLoader

func load_data(file_path: String) -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var error := config.load(file_path)
	
	if error != OK:
		var error_msg := "SettingsManager: Failed to load settings (Error: %s)" % error_string(error)
		print_rich("[color=yellow]%s[/color]" % error_msg)
		return SettingsManager.DEFAULTS.duplicate(true)
	
	var loaded_data: Dictionary[String, Dictionary]
	for section in config.get_sections():
		loaded_data[section] = {}
		for key in config.get_section_keys(section):
			loaded_data[section][key] = config.get_value(section, key)
	
	return loaded_data
