extends Node

func load_theme() -> void:
	var color_scheme: Dictionary = SettingsManager.current_settings.color_scheme
	
	#region main 
	var main_theme: Theme = ObjectReferences.main.theme
	
	if color_scheme.background != null:
		main_theme.set_stylebox(&"panel", &"Panel", StyleBoxFlat.new())
		main_theme.get_stylebox(&"panel", &"Panel").bg_color = color_scheme.background
	else:
		main_theme.clear_stylebox(&"panel", &"Panel")
	#endregion
	
	#region settings panel
	if ObjectReferences.settings_panel:
		var settings_theme: Theme = ObjectReferences.settings_panel.theme
		
		# header hseparator line color
		if color_scheme.main_text:
			settings_theme.set_stylebox(&"style", &"HSeparator", StyleBoxLine.new())
			settings_theme.get_stylebox(&"style", &"HSeparator").color = color_scheme.main_text
		else:
			settings_theme.clear_stylebox(&"separator", &"HSeparator")
		
		# selection outline
		if color_scheme.outline_selection:
			settings_theme.set_color(&"font_outline_color", &"ButtonTab", color_scheme.outline_selection)
		else:
			settings_theme.clear_color(&"font_outline_color", &"ButtonTab")
	#endregion

func set_color_scheme(color_scheme: Dictionary) -> void:
	var current_color_scheme: Dictionary = SettingsManager.current_settings.color_scheme
	
	var main_theme: Theme = ObjectReferences.main.theme
	var settings_theme: Theme = ObjectReferences.settings_panel.theme
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	
	settings_theme.set_stylebox(&"pressed", &"Button", StyleBoxFlat.new())
	settings_theme.get_stylebox(&"pressed", &"Button").bg_color = Color.LIGHT_GRAY
	settings_theme.set_color(&"font_pressed_color", &"Button", Color.BLACK)
	
	#region background value
	if current_color_scheme.background != color_scheme.background:
		if color_scheme.background != null:
			main_theme.set_stylebox(&"panel", &"Panel", StyleBoxFlat.new())
			main_theme.get_stylebox(&"panel", &"Panel").bg_color = color_scheme.background
		else:
			main_theme.clear_stylebox(&"panel", &"Panel")
	#endregion
	
	#region main text value
	if current_color_scheme.main_text != color_scheme.main_text:
		main_theme.set_color(&"font_color", &"RichTextLabel", color_scheme.main_text)
		
		settings_theme.get_stylebox(&"separator", &"HSeparator").color = color_scheme.main_text
		
		test_field_theme.set_color(&"font_color", &"RichTextLabel", color_scheme.main_text)
		test_field_theme.set_color(&"font_color", &"LineEdit", color_scheme.main_text)
		test_field_theme.set_color(&"font_color", &"Label", color_scheme.main_text)
		
		ObjectReferences.ui_container.set_icon_mod(color_scheme.main_text)
	#endregion
	
	#region outline selection
	if current_color_scheme.outline_selection != color_scheme.outline_selection:
		settings_theme.set_color(&"font_outline_color", &"ButtonTab", color_scheme.outline_selection)
	#endregion
	
	TypingManager.correct_typed_color = color_scheme.typed_correct
	TypingManager.wrong_typed_color = color_scheme.typed_error
	TypingManager.correct_word_color = color_scheme.submit_correct
	TypingManager.wrong_word_color = color_scheme.submit_error
	
	SettingsManager.current_settings.color_scheme = color_scheme

func set_font(font: Font) ->void:
	if font == SettingsManager.current_settings.appearance.font: return
	
	var main_theme: Theme = ObjectReferences.main.theme
	var settings_theme: Theme = ObjectReferences.settings_panel.theme
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
		for type in settings_types:
			settings_theme.clear_font(&"font", type)
	
	SettingsManager.current_settings.appearance.font = font

func set_font_size(font_size: int) -> void:
	if font_size == SettingsManager.current_settings.appearance.font_size: return
	
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	
	if test_field_theme.get_font_size(&"normal_font", &"RichTextLabel") != font_size:
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", font_size)
	
	SettingsManager.current_settings.appearance.font_size = font_size

func sync_settings_panel() -> void:
	var font: Font = SettingsManager.current_settings.appearance.font
	var settings_theme: Theme = ObjectReferences.settings_panel.theme
	var types: Array[StringName] = [&"Button", &"CheckBox", &"Label", &"OptionButton", &"TabContainer"]
	
	if font:
		for type in types:
			if settings_theme.get_font(&"font", &"TabContainer") != font:
				settings_theme.set_font(&"font", type, font)
	else:
		for type in types:
			settings_theme.clear_font(&"font", type)
	
	# NOTE -- might change this
	if SettingsManager.current_settings.color_scheme.main_text:
		var color: Color = SettingsManager.current_settings.color_scheme.main_text
		settings_theme.get_stylebox(&"separator", &"HSeparator").color = color
	
	# NOTE -- might change this
	if SettingsManager.current_settings.color_scheme.outline_selection:
		var outline_color: Color = SettingsManager.current_settings.color_scheme.outline_selection
		settings_theme.set_color(&"font_outline_color", &"ButtonTab", outline_color)

func sync_main() -> void:
	var font = SettingsManager.current_settings.appearance.font
	var font_size = SettingsManager.current_settings.appearance.font_size
	
	var main_theme: Theme = ObjectReferences.main.theme
	var test_field_theme: Theme = ObjectReferences.test_field_panel.theme
	var wpm_theme: Theme = ObjectReferences.wpm_panel.theme
	
	var styles := [&"normal", &"focus"]
	if !SettingsManager.current_settings.appearance.visible_typing_field:
		for style in styles:
			test_field_theme.set_stylebox(style, &"LineEdit", StyleBoxEmpty.new())
	else:
		for style in styles:
			test_field_theme.clear_stylebox(style, &"LineEdit")
	
	if test_field_theme.get_font_size(&"normal_font", &"RichTextLabel") != font_size:
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", font_size)
	
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
	else:
		main_theme.clear_font(&"normal_font", &"Tip")
		
		test_field_theme.clear_font(&"normal_font", &"RichTextLabel")
		test_field_theme.clear_font(&"font", &"Label")
		test_field_theme.clear_font(&"font", &"LineEdit")
		
		var types: Array[String] = [&"HeaderLarge", &"HeaderSmall", &"Label"]
		for type in types:
			wpm_theme.clear_font(&"font", type)
