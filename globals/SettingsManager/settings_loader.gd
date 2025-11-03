extends Node
class_name SettingsLoader

func load_data(file_path: String) -> Dictionary[String, Dictionary]:
	var config := ConfigFile.new()
	var error := config.load(file_path)
	
	if error != OK:
		var error_msg := "SettingsManager: Failed to load settings (Error: %s)" % error_string(error)
		print_rich("[color=yellow]%s[/color]" % error_msg)
		return SettingsManager.DEFAULTS.duplicate_deep()
	
	var loaded_data := _fetch(config)
	_sanitize(loaded_data)
	
	return loaded_data

func _fetch(config: ConfigFile) -> Dictionary[String, Dictionary]:
	var fetched: Dictionary[String, Dictionary]
	for section in config.get_sections():
		fetched[section] = {}
		for key in config.get_section_keys(section):
			fetched[section][key] = config.get_value(section, key)
	
	return fetched

func _sanitize(loaded_data: Dictionary[String, Dictionary]) -> void:
	for section in SettingsManager.DEFAULTS:
		var default_section := SettingsManager.DEFAULTS[section]
		var loaded_section := loaded_data[section]
		
		for key in default_section:
			var default_value = default_section[key]
			var loaded_value = loaded_section[key]
			
			if typeof(default_value) != typeof(loaded_value):
				loaded_section[key] = default_value
		
		loaded_data[section] = loaded_section
