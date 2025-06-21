extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tab"):
		StateMachine.change_state(StateMachine.State.RESET)
