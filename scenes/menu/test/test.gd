extends Control
class_name TestMenu

func _init() -> void:
	ObjectReferences.test_menu = self

func _ready() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
