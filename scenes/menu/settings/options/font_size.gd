extends HBoxContainer
class_name FontSizeOption

#@onready var spin_box: SpinBox = $SpinBox

func _ready() -> void:
	_update_selection()

func _update_selection() -> void:
	$SpinBox.value = ThemeManager.current_font_size

func _on_spin_box_value_changed(value: float) -> void:
	ThemeManager.set_font_size(roundi(value))
