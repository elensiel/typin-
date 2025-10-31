extends Control
class_name MainUI

func _on_button_pressed() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
