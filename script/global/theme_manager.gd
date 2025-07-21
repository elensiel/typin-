extends Node

func load_theme() -> void:
	set_font(SettingsManager.current_settings.appearance.font)
	set_font_size(SettingsManager.current_settings.appearance.font_size)
	set_line_edit_visibility(SettingsManager.current_settings.appearance.visible_typing_field)

func set_font(font: Font) -> void:
	var main_theme: Theme = ObjectReferences.main.theme
	#var settings_theme: Theme = ObjectReferences.settings_panel.theme
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	var wpm_theme: Theme = ObjectReferences.wpm_panel.theme
	
	if font:
		if main_theme.get_font(&"normal_font", &"Tip") != font:
			main_theme.set_font(&"normal_font", &"Tip", font)
		
		if test_field_theme.get_font(&"normal_font", &"RichTextLabel") != font:
			test_field_theme.set_font(&"normal_font", &"RichTextLabel", font)
			test_field_theme.set_font(&"font", &"Label", font)
			test_field_theme.set_font(&"font", &"LineEdit", font)
		
		if wpm_theme.get_font(&"font", &"Label") != font:
			var types: Array[String] = [&"HeaderLarge", &"HeaderSmall", &"Label"]
			for type in types:
				wpm_theme.set_font(&"font", type, font)
		
		if ObjectReferences.settings_panel != null:
			var settings_theme: Theme = ObjectReferences.settings_panel.theme
			if settings_theme.get_font(&"font", &"TabContainer") != font:
				var types: Array[StringName] = [&"Button", &"CheckBox", &"Label", &"OptionButton", &"TabContainer"]
				for type in types:
					settings_theme.set_font(&"font", type, font)
	else:
		main_theme.clear_font(&"normal_font", &"Tip")
		
		test_field_theme.clear_font(&"normal_font", &"RichTextLabel")
		test_field_theme.clear_font(&"font", &"Label")
		test_field_theme.clear_font(&"font", &"LineEdit")
		
		var types: Array[String] = [&"HeaderLarge", &"HeaderSmall", &"Label"]
		for type in types:
			wpm_theme.clear_font(&"font", type)
		
		var settings_types: Array[StringName] = [
			&"Button", 
			&"CheckBox", 
			&"Label", 
			&"OptionButton", 
			&"TabContainer",
		]
		
		if ObjectReferences.settings_panel != null:
			var settings_theme: Theme = ObjectReferences.settings_panel.theme
			for type in settings_types:
				settings_theme.clear_font(&"font", type)
	
	SettingsManager.current_settings.appearance.font = font

func set_font_size(font_size: int) -> void:
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", font_size)
	SettingsManager.current_settings.appearance.font_size = font_size

func set_line_edit_visibility(visible: bool = true) -> void:
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	var styles: Array[StringName] = [&"normal", &"focus"]
	
	for style in styles:
		if visible && test_field_theme.get_stylebox(style, &"LineEdit") != null:
			test_field_theme.clear_stylebox(style, &"LineEdit")
		else:
			test_field_theme.set_stylebox(style, &"LineEdit", StyleBoxEmpty.new())
	
	SettingsManager.current_settings.appearance.visible_typing_field = visible
