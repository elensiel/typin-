extends MarginContainer
class_name UiContainer

func _init() -> void: ObjectReferences.ui_container = self

func update_ui() -> void:
	var settings_button := $Settings
	settings_button.visible = (StateMachine.current_state == StateMachine.State.NEW) || (StateMachine.current_state == StateMachine.State.END) || (StateMachine.current_state == StateMachine.State.INTERRUPTED)
	
	var restart_tip := $Tip/RestartTip 
	
	if SettingsManager.current_settings.general.quick_restart_off:
		ObjectReferences.restart_test_button.visible = StateMachine.current_state != StateMachine.State.SETTINGS
		restart_tip.text = &"Press Tab + Enter to restart"
	else:
		ObjectReferences.restart_test_button.visible = SettingsManager.current_settings.general.quick_restart_off
		
		match SettingsManager.current_settings.general.quick_restart:
			InputManager.TAB:
				restart_tip.text = &"Press Tab to restart"
			InputManager.ESC:
				restart_tip.text = &"Press Esc to restart"
			InputManager.ENTER:
				restart_tip.text = &"Press Enter to restart"
	
	if !settings_button.visible:
		restart_tip.text = &""
