extends Control
class_name Main

func _init() -> void:
	ObjectReferences.main = self

func _enter_tree() -> void:
	# update windo
	if DisplayServer.window_get_mode() != SettingsManager.current_settings.general.window_mode:
		DisplayServer.window_set_mode(SettingsManager.current_settings.general.window_mode)
	
	var test_field := preload("res://scene/test_field_panel.tscn").instantiate()
	var wpm := preload("res://scene/wpm_panel.tscn").instantiate()
	
	add_child(test_field)
	add_child(wpm)

func _ready() -> void:
	ThemeManager.load_theme()
	StateMachine.change_state(StateMachine.State.NEW)
