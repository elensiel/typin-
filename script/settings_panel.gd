extends MarginContainer

const MINIMUM_SIZE_RATIO: float = 1.75

func _init() -> void:
	ObjectReferences.settings_panel = self
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / MINIMUM_SIZE_RATIO
	custom_minimum_size.y = SettingsManager.BASE_RESOLUTION.y / MINIMUM_SIZE_RATIO

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))

func _ready() -> void:
	for node in get_tree().get_nodes_in_group(&"option_handler"):
		node.update_selection()

func _exit_tree() -> void: 
	SettingsManager.save_settings()
