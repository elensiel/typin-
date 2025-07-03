extends MarginContainer
class_name UiContainer

func _init() -> void: ObjectReferences.ui_container = self

func update_ui() -> void:
	$Settings.visible = (StateMachine.current_state == StateMachine.State.NEW) || (StateMachine.current_state == StateMachine.State.END)
	
	if SettingsManager.current_settings.keybindings.restart_key_off:
		ObjectReferences.restart_test_button.visible = StateMachine.current_state != StateMachine.State.SETTINGS
	else:
		ObjectReferences.restart_test_button.visible = SettingsManager.current_settings.keybindings.restart_key_off
