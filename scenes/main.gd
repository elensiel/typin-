extends Node
class_name Main

func _ready() -> void:
	if StateMachine.current_state == StateMachine.State.SETTINGS:
		StateMachine.change_state(StateMachine.State.SETTINGS)
	else:
		StateMachine.change_state(StateMachine.State.NEW)
