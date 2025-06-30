extends Control

func _enter_tree() -> void:
	var nodes: Array[PanelContainer] = [
		preload("res://scene/test_field_panel.tscn").instantiate(),
		preload("res://scene/wpm_panel.tscn").instantiate(),
		preload("res://scene/settings_panel.tscn").instantiate(),
	]
	
	for node in nodes:
		add_child(node)
		node.set_anchors_preset(Control.PRESET_CENTER)

func _ready() -> void: StateMachine.change_state(StateMachine.State.NEW)
