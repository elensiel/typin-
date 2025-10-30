extends Node
class_name Main

func _ready() -> void:
	var test_scene: TestMenu = preload("res://scenes/menu/test/test.tscn").instantiate()
	
	add_child(test_scene)
