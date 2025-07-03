extends MarginContainer
class_name UiContainer

func _init() -> void: ObjectReferences.ui_container = self

func hide_ui() -> void:
	$Settings.visible = false
	
	$Tip/RestartTip.text = ""
	$Tip/QuickSettingsTip.text = ""
	
	if StateMachine.current_state == StateMachine.State.TYPING:
		if SettingsManager.current_settings.keybindings.restart_key_off:
			ObjectReferences.restart_test_button.visible = true
	elif StateMachine.current_state == StateMachine.State.SETTINGS:
		ObjectReferences.restart_test_button.visible = false

func show_ui() -> void:
	$Settings.visible = true
	
	#for child in $Tip.get_children():
		#child.visible = true
	
	if !SettingsManager.current_settings.keybindings.restart_key_off:
		ObjectReferences.restart_test_button.visible = false
