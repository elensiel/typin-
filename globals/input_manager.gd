extends Node

## FONT SIZE
const CTRL_EQUAL := &"ctrl+equal"
const CTRL_MINUS := &"ctrl+minus"
## RESTART SHORTCUTS
const ENTER := &"enter"
const ESC := &"esc"
const TAB := &"tab"

var shortcut_enabled: bool = SettingsManager.current_settings.general.shortcut_enabled
var shortcut_key: StringName = SettingsManager.current_settings.general.shortcut_key

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not shortcut_enabled and event.is_action_pressed(TAB):
			_switch_focus()
		elif event.is_action_pressed(shortcut_key):
			StateMachine.change_state(StateMachine.State.NEW)
	
	# show mouse cursor when there is mouse motion
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_HIDDEN:
		StateMachine.change_state(StateMachine.State.INTERRUPTED)

## switch button focus between restart button and line edit
func _switch_focus() -> void:
	if not ObjectReferences.line_edit.visible or ObjectReferences.restart_button.has_focus():
		ObjectReferences.line_edit.grab_focus()
	else:
		ObjectReferences.restart_button.grab_focus()

func set_shortcut_enabled(enabled: bool = true) -> void:
	shortcut_enabled = enabled
	SettingsManager.save_changes()

func set_shortcut_key(key: StringName) -> void:
	shortcut_key = key
	SettingsManager.save_changes()
