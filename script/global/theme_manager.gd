extends Node

func update_theme(defaults: bool = false) -> void:
	var font: Font = SettingsManager.changed_settings.appearance.font
	var font_size: int = SettingsManager.changed_settings.appearance.font_size
	
	if defaults:
		font = SettingsManager.DEFAULT_SETTINGS.appearance.font
		font_size = SettingsManager.DEFAULT_SETTINGS.appearance.font_size
	
	# Font changes
	if ObjectReferences.settings_panel:
		var settings_theme: Theme = ObjectReferences.settings_panel.theme
		if settings_theme.get_font(&"font", &"TabContainer") != font:
			var types: Array[StringName] = [&"Button", &"CheckBox", &"Label", &"OptionButton", &"TabContainer"]
			for type in types:
				settings_theme.set_font(&"font", type, font)
	
	var main_theme: Theme = ObjectReferences.main.theme
	if main_theme.get_font(&"normal_font", &"Tip") != font:
		main_theme.set_font(&"normal_font", &"Tip", font)
	
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	if test_field_theme.get_font(&"normal_font", &"RichTextLabel") != font:
		test_field_theme.set_font(&"normal_font", &"RichTextLabel", font)
		test_field_theme.set_font(&"font", &"Label", font)
		test_field_theme.set_font(&"font", &"LineEdit", font)
	
	if test_field_theme.get_font_size(&"normal_font", &"RichTextLabel") != font_size:
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", font_size)
	
	var wpm_theme: Theme = ObjectReferences.wpm_panel.theme
	if wpm_theme.get_font(&"font", &"Label") != font:
		var types: Array[String] = [&"HeaderLarge", &"HeaderSmall", &"Label"]
		for type in types:
				wpm_theme.set_font(&"font", type, font)
