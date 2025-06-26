extends Node

const BASE_RESOLUTION := Vector2i(1920, 1080)

var default_settings: Dictionary[String, Dictionary] = {
	"general" : {
		"lines_shown" : 3,
	},
	"display" : {
		#"resolution" : Vector2i(1920, 1080),
		"window_mode" : DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED,
		"resizable" : true,
	},
}

var current_settings: Dictionary[String, Dictionary] = default_settings.duplicate(true)
var changed_settings: Dictionary[String, Dictionary] = current_settings.duplicate(true)

func apply_settings() -> void:
	# display
	#DisplayServer.window_set_size(changed_settings.display.resolution)
	#print("Log: Display resolution set to " + str(changed_settings.display.resolution))
	
	DisplayServer.window_set_mode(changed_settings.display.window_mode)
	print(&"Log: Window mode set to " + str(changed_settings.display.window_mode))
	
	get_viewport().get_window().unresizable = changed_settings.display.resizable
	
	# general
	for node in get_tree().get_nodes_in_group(&"adjustable_displays"):
		if node.has_method(&"adjust_display"):
			node.adjust_display()
			print(&"Log: Node [" + node.name + &"] adjusted display.")
		else:
			printerr(&"Log Error: Node [" + str(node) + &"] does not have adjust_display() method.")
	
	current_settings = changed_settings
	print(&"Log: Current settings updated with changed settings.")

func restore_default_settings() -> void:
	# display settings
	#DisplayServer.window_set_size(default_settings.display.resolution)
	#print("Log: Display resolution set to " + str(default_settings.display.resolution))
	
	DisplayServer.window_set_mode(default_settings.display.window_mode)
	print(&"Log: Window mode set to " + str(default_settings.display.window_mode))
	
	get_viewport().get_window().unresizable = default_settings.display.resizable
	
	# general settings
	for node in get_tree().get_nodes_in_group(&"adjustable_displays"):
		if node.has_method(&"adjust_display"):
			node.adjust_display()
			print(&"Log: Node [" + node.name + &"] adjusted display.")
		else:
			printerr(&"Log Error: Node [" + node.name + &"] does not have adjust_display() method.")
	
	current_settings = default_settings
	print(&"Log: Current settings updated with default settings.")
