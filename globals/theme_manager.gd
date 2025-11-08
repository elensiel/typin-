extends Node

enum Owner {
	MAIN,
	RESULT,
	SETTINGS,
	TEST,
}

var themes: Array[Theme] = [ null, null, null, null ]

var current_font: Font
var current_font_size: int

func _ready() -> void:
	set_font(SettingsManager.current_settings.appearance.font, false)
	set_font_size(SettingsManager.current_settings.appearance.font_size, false)

func set_font(new_font: Font, to_save: bool = true) -> void:
	if new_font == current_font: 
		return
	
	current_font = new_font
	for theme in themes:
		var types := theme.get_type_list()
		for type in types:
			var font_types := ThemeDB.get_default_theme().get_font_list(type)
			for font_type in font_types:
				theme.set_font(font_type, type, current_font)
	
	if to_save:
		SettingsManager.save_changes()

func set_font_size(size: int, to_save: bool = true) -> void:
	if size == current_font_size: 
		return
	
	current_font_size = size
	var font_size_types := ThemeDB.get_default_theme().get_font_size_list("RichTextLabel")
	for types in font_size_types:
		themes[Owner.TEST].set_font_size(types, "RichTextLabel", current_font_size)
	
	if to_save: 
		SettingsManager.save_changes()
