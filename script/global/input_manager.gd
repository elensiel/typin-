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
				StateMachine.change_state(StateMachine.State.NEW)
				call_deferred(&"focus_line_edit")
	elif event.is_action_pressed(ESC):
		if StateMachine.current_state == StateMachine.State.SETTINGS:
			ObjectReferences.settings_panel.queue_free()
			StateMachine.change_state(StateMachine.State.NEW)
		call_deferred(&"focus_line_edit")
	elif event.is_action_pressed(CTRL_SHIFT_P):
		if StateMachine.current_state != StateMachine.State.SETTINGS:
			StateMachine.change_state(StateMachine.State.SETTINGS)
	
	# show cursor visibility when there is mouse motion
	if Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		if event is InputEventMouseMotion:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_key_input(event: InputEvent) -> void:
	if SettingsManager.current_settings.keybindings.restart_key_off && event.is_action_pressed(TAB):
		if StateMachine.current_state == StateMachine.State.END:
			ObjectReferences.restart_test_button.grab_focus()

func focus_line_edit() -> void: TypingManager.line_edit.edit()
