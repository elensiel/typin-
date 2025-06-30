extends PanelContainer
class_name WpmPanel

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))
	NodeReferences.wpm_panel = self
	UiManager.set_scale(self)
	visible = false
