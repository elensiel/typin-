extends PanelContainer
class_name TestField

func _ready() -> void:
	_scale()
	
	var text_field: RichTextLabel = $VBoxContainer/MarginContainer/RichTextLabel
	var line_edit: LineEdit = $VBoxContainer/HBoxContainer/LineEdit
	var timer_label: Label = $VBoxContainer/HBoxContainer/Label
	
	TextManager.connect_label(text_field)
	TypingManager.connect_line_edit(line_edit)
	TimerManager.connect_label(timer_label)

func _scale() -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	
	var target_scale_x: float = viewport_size.x / 1920
	var target_scale_y: float = viewport_size.y / 1080
	
	scale = Vector2(target_scale_x, target_scale_y)
	
	custom_minimum_size.x = Defaults.test_field_min_size_x
	custom_minimum_size.y = Defaults.test_field_min_size_y
