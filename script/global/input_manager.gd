extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tab"):
		StateMachine.change_state(StateMachine.State.RESET)
	
	# cursor visibility
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
