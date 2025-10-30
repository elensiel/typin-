extends CanvasLayer
class_name DebugTest

@onready var value: Label = $VBoxContainer/HBoxContainer/Value

func _init() -> void:
	ObjectReferences.debug_test = self
