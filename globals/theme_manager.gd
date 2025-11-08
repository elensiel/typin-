extends Node

enum Owner {
	MAIN,
	RESULT,
	SETTINGS,
	TEST,
}

var themes: Array[Theme] = [ null, null, null, null ]

func set_font(new_font: Font) -> void:
	
	# TODO -- add checking if new_font != current_font
	
	for theme in themes:
		var types := theme.get_type_list()
		for type in types:
			var font_types := ThemeDB.get_default_theme().get_font_list(type)
			for font_type in font_types:
				theme.set_font(font_type, type, new_font)
	
	# TODO -- sync with SettingsManager here
