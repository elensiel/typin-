extends Resource
class_name Defaults

@warning_ignore_start("integer_division")
const test_field: Dictionary = {
	"font_size" : {
		"line_edit" : 30,
		"text_field" : 45,
		"timer_label" : 30,
	},
	"custom_min_size" : Vector2(1920 / 2, 1080 / 5),
}

const wpm_panel: Dictionary = {
	"font_size" : {
		"net_wpm" : 45,
		"net_wpm_word" : 20,
		"misc_data" : 30,
	},
	"custom_min_size" : Vector2(1920 / 5, 0)
}
