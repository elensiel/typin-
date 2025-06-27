extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"tab"):
		StateMachine.change_state(StateMachine.State.RESET)
	elif event.is_action_pressed(&"esc"):
		if StateMachine.cur_state != StateMachine.State.SETTINGS:
			StateMachine.change_state(StateMachine.State.SETTINGS)
		else:
			StateMachine.change_state(StateMachine.State.NEW)
	
	# cursor visibility
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
