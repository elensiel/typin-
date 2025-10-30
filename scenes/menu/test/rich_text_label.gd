extends RichTextLabel

func _draw() -> void:
	var font: Font = owner.theme.get_font(&"normal_font", &"RichTextLabel")
	var font_size: int = owner.theme.get_font_size(&"normal_font_size", &"RichTextLabel")
	var height: float = font.get_height(font_size)
	var target_lines: int = 3 # TODO relative to settings
	
	custom_minimum_size.y = height * target_lines

func _enter_tree() -> void:
	TextManager.connect_label(self)
