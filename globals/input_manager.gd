extends Node

const CTRL_EQUAL := &"ctrl+equal"
const CTRL_MINUS := &"ctrl+minus"
const ENTER := &"enter"
const ESC := &"esc"
const TAB := &"tab"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(TAB):
		_switch_focus()

func _switch_focus() -> void:
	if ObjectReferences.line_edit.has_focus():
		ObjectReferences.restart_button.grab_focus()
	elif ObjectReferences.restart_button.has_focus():
		ObjectReferences.line_edit.grab_focus()
