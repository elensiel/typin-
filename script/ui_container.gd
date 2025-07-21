extends MarginContainer
class_name UiContainer

@onready var settings_button: Button = $Settings
@onready var restart_button: Button = $Tip/Restart
@onready var restart_tip: RichTextLabel = $Tip/RestartTip


func _init() -> void:
	ObjectReferences.ui_container = self

#func _ready() -> void:
	#if SettingsManager.current_settings.color_scheme.main_text:
		#set_icon_mod(SettingsManager.current_settings.color_scheme.main_text)
#
#func set_icon_mod(color: Color) -> void:
	#$Settings.self_modulate = color
	#$Tip/Restart.self_modulate = color

func update_ui() -> void:
	settings_button.visible = (
		StateMachine.current_state == StateMachine.State.NEW ||
		StateMachine.current_state == StateMachine.State.INTERRUPTED ||
		StateMachine.current_state == StateMachine.State.DONE
	)
	
	if !SettingsManager.current_settings.general.quick_restart_active:
		restart_button.visible = StateMachine.current_state != StateMachine.State.SETTINGS
		restart_tip.text = &"Press Tab + Enter to restart"
	else:
		restart_button.visible = false
		restart_tip.text = &"Press " + InputManager.quick_restart_key + &" to restart"
	
	if !settings_button.visible: restart_tip.text = &""

func _on_settings_pressed() -> void:
	StateMachine.change_state(StateMachine.State.SETTINGS)

func _on_restart_pressed() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
