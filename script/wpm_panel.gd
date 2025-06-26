extends PanelContainer
class_name WpmPanel

func _ready() -> void:
	adjust_display()
	visible = false
	StateMachine.wpm_panel = self

func adjust_display() -> void:
	UiManager.scale(self)
	custom_minimum_size.x = (SettingsManager.BASE_RESOLUTION.x / 5) * 1.4
	custom_minimum_size.y = 0
