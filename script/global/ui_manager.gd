extends Node

func scale(node: Control) -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var target_scale_x: float = viewport_size.x / SettingsManager.BASE_RESOLUTION.x
	var target_scale_y: float = viewport_size.y / SettingsManager.BASE_RESOLUTION.y
	node.scale = Vector2(target_scale_x, target_scale_y)
