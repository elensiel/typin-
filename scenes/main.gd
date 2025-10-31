extends Node
class_name Main

func _ready() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
