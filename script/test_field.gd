extends PanelContainer
class_name TestField

func _enter_tree() -> void: 
	theme = ThemeManager.test_field
	adjust_display()
	visible = true
	StateMachine.test_field = self

func adjust_display() -> void:
	UiManager.scale(self)
	@warning_ignore_start("integer_division")
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 2
