extends MarginContainer

@onready var restart_button: Button = $Tip/Restart

func _init(): NodeReferences.ui_container = self

func hide_ui() -> void:
	for child in get_children():
		child.visible = false
	
	for child in $Tip.get_children():
		child.visible = false
	
	if InputManager.restart_key_off && StateMachine.current_state == StateMachine.State.TYPING:
		$Tip.visible = true
		$Tip/Restart.visible = true

func show_ui() -> void:
	for child in get_children():
		child.visible = true
	
	for child in $Tip.get_children():
		child.visible = true
	
	if !InputManager.restart_key_off:
		$Tip/Restart.visible = false
