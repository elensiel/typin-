extends PanelContainer
class_name TestFieldPanel

func _draw() -> void:
	var font: Font = theme.get_font(&"normal_font_size", &"RichTextLabel")
	var font_size: int = theme.get_font_size(&"normal_font_size", &"RichTextLabel")
	var height: float = font.get_height(font_size)
	var target_lines: int = SettingsManager.current_settings.general.lines_shown
	
	var node := $VBoxContainer/Text
	node.custom_minimum_size.y = height * target_lines

func _enter_tree() -> void:
	print("Node: Setting up " + str(self))
	NodeReferences.test_field_panel = self
	
	UiManager.set_scale(self)
	UiManager.set_custom_minimum_size(
		self,
		SettingsManager.BASE_RESOLUTION.x / 1.50,
		SettingsManager.BASE_RESOLUTION.y / 1.75
	)
	
	visible = true
