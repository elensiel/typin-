extends Node

const ESC := &"esc"
const TAB := &"tab"
const ENTER := &"enter"
const CTRL_SHIFT_P := &"CS-p"

var restart_key: StringName = SettingsManager.current_settings.keybindings.restart_key
var restart_key_off: bool = SettingsManager.current_settings.keybindings.restart_key_off

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(restart_key):
		if StateMachine.current_state == StateMachine.State.SETTINGS:
			StateMachine.change_state(StateMachine.State.NEW)
		else:
			if !restart_key_off:
				StateMachine.change_state(StateMachine.State.RESTART)
				call_deferred(&"focus_line_edit")
	
	# show cursor visibility when there is mouse motion
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func focus_line_edit() -> void: TypingManager.line_edit.edit()
