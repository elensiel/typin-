extends PanelContainer
class_name Settings

func _enter_tree() -> void:
	adjust_display()
	visible = false
	StateMachine.settings = self

func adjust_display() -> void:
	UiManager.scale(self)
	@warning_ignore_start("integer_division")
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 1.75
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / 1.75
