extends PanelContainer
class_name WpmPanel

func _init() -> void: ObjectReferences.wpm_panel = self

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))
	visible = false
