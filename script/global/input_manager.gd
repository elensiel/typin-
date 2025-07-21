extends Node

const ESC := &"Esc"
const TAB := &"Tab"
const ENTER := &"Enter"
const CTRL_SHIFT_P := &"CS-p"

var quick_restart_key: StringName = SettingsManager.current_settings.general.quick_restart
var quick_restart_key_active: bool = SettingsManager.current_settings.general.quick_restart_active

func _input(event: InputEvent) -> void:
	# inputs while in test field
	if StateMachine.current_state != StateMachine.State.SETTINGS:
		if quick_restart_key_active && event.is_action_pressed(quick_restart_key):
			StateMachine.change_state(StateMachine.State.NEW)
			call_deferred(&"focus_line_edit")
		elif event.is_action_pressed(CTRL_SHIFT_P):
			StateMachine.change_state(StateMachine.State.SETTINGS)
	
	# inputs while in settings panel
	elif StateMachine.current_state == StateMachine.State.SETTINGS:
		if event.is_action_pressed(ESC) || event.is_action_pressed(quick_restart_key):
			StateMachine.change_state(StateMachine.State.NEW)
			call_deferred(&"focus_line_edit")
	
	# show cursor visibility when there is mouse motion
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN && event is InputEventMouseMotion:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		# interruption while typing
		if StateMachine.current_state == StateMachine.State.TYPING:
			StateMachine.change_state(StateMachine.State.INTERRUPTED)

func focus_line_edit() -> void: TypingManager.line_edit.edit()
