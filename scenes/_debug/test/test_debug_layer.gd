extends CanvasLayer
class_name DebugTest

@onready var current_word_value: Label = $VBoxContainer/CurrentWord/Value

func _init() -> void:
	ObjectReferences.debug_test = self

func update_current_word() -> void:
	current_word_value.text = TypingManager.current_word
