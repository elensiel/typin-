extends Node

const ESC := &"esc"
const TAB := &"tab"
const ENTER := &"enter"
const CTRL_SHIFT_P := &"CS-p"

# TODO -- save to keybindings settings
var reset_key: StringName = TAB
var settings_key: StringName = ESC

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(reset_key):
		StateMachine.change_state(StateMachine.State.RESET)
	elif event.is_action_pressed(settings_key):
		# go to settings otherwise back to typing test
		if StateMachine.current_state != StateMachine.State.SETTINGS:
			StateMachine.change_state(StateMachine.State.SETTINGS)
		else:
			StateMachine.change_state(StateMachine.State.NEW)
			TypingManager.line_edit.edit()
	
	# show cursor visibility when there is mouse motion
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
