extends Control
class_name TestMenu

func _ready() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
