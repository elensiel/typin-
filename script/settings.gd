extends PanelContainer
class_name Settings

func _ready() -> void: 
	adjust_display()
	#visible = false
	StateMachine.settings = self

func adjust_display() -> void:
	UiManager.scale(self)
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 2
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / 2
