extends PanelContainer
class_name WpmPanel

func _ready() -> void:
	_scale()
	StateMachine.wpm_panel = self

func _scale() -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	
	var target_scale_x: float = viewport_size.x / 1920
	var target_scale_y: float = viewport_size.y / 1080
	
	scale = Vector2(target_scale_x, target_scale_y)
	
	custom_minimum_size.x = Defaults.wpm_panel.custom_min_size.x
	custom_minimum_size.y = Defaults.wpm_panel.custom_min_size.y
