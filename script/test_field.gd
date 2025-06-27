extends PanelContainer
class_name TestField

func _ready() -> void:
	adjust_display()
	visible = true
	StateMachine.test_field = self

func adjust_display() -> void:
	UiManager.scale(self)
	@warning_ignore_start("integer_division")
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 2
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / 5
