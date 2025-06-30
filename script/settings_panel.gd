extends PanelContainer
class_name SettingsPanel

var font_size
var font_scale
var lines_shown
var window_mode
var resizable

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))
	NodeReferences.settings_panel = self
	
	UiManager.set_scale(self)
	UiManager.set_custom_minimum_size(
		self,
		SettingsManager.BASE_RESOLUTION.x / 1.75,
		SettingsManager.BASE_RESOLUTION.y / 1.75
	)
	
	visible = false

func _ready() -> void: update_selection()

## updates button selected items
func update_selection() -> void:
	# GENERAL
	font_size.selected = (SettingsManager.current_settings.general.font_size - 30) / 2
	#font_scale.selected = roundi(5.0 - (10.0 * (1.0 - SettingsManager.current_settings.general.font_scale)))
	lines_shown.selected = SettingsManager.current_settings.general.lines_shown - 1
	
	# DISPLAY
	# Window Mode
	window_mode.selected = DisplayServer.window_get_mode()
	resizable.button_pressed = SettingsManager.current_settings.display.resizable
