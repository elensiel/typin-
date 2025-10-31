extends CanvasLayer
class_name DebugTest

@onready var correct_keystrokes_value: Label = $VBoxContainer/CorrectKeystrokes/Value
@onready var wrong_keystrokes_value: Label = $VBoxContainer/WrongKeystrokes/Value
@onready var missed_keystrokes_value: Label = $VBoxContainer/MissedKeystrokes/Value

func _init() -> void:
	ObjectReferences.debug_test = self
