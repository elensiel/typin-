extends Node

@onready var test_field_theme := preload("res://resource/test_field.tres")

enum SETTING_PRESET {
	DEFAULTS,
	CHANGED,
}

const BASE_RESOLUTION := Vector2i(1920, 1080)

const DEFAULT_SETTINGS: Dictionary[String, Dictionary] = {
	"general" : {
		"font_size" : 46,
		"font_scale" : 1.0,
		"lines_shown" : 3,
	},
	"display" : {
		"window_mode" : DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED,
		"resizable" : true,
	},
}

var current_settings: Dictionary[String, Dictionary] = DEFAULT_SETTINGS.duplicate(true)
var changed_settings: Dictionary[String, Dictionary] = current_settings.duplicate(true)

func apply_settings(preset: SETTING_PRESET) -> void:
	var temp: Dictionary[String, Dictionary] = DEFAULT_SETTINGS if preset == SETTING_PRESET.DEFAULTS else changed_settings
	
	# DISPLAY
	if temp.display.window_mode != current_settings.display.window_mode:
		DisplayServer.window_set_mode(temp.display.window_mode)
	
	if temp.display.resizable != current_settings.display.resizable:
		get_viewport().get_window().unresizable = !temp.display.resizable
	
	# GENERAL
	if (temp.general.font_size != current_settings.general.font_size) or (temp.general.font_scale != current_settings.general.font_scale):
		test_field_theme.set_font_size(&"normal_font_size", &"RichTextLabel", roundi(temp.general.font_size * temp.general.font_scale))
	
	for node in get_tree().get_nodes_in_group(&"adjustable_displays"):
		if node.has_method(&"adjust_display"):
			node.adjust_display()
			print(&"Log: Node [" + node.name + &"] adjusted display.")
		else:
			printerr(&"Log Error: Node [" + str(node) + &"] does not have adjust_display() method.")
	
	current_settings = temp.duplicate(true)
	print(&"Log: Current settings updated with changed settings.")
	
	# match selected items
	if preset == SETTING_PRESET.DEFAULTS:
		StateMachine.settings.visible = false
		StateMachine.settings.visible = true
