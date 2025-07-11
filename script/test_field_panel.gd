extends PanelContainer
class_name TestFieldPanel

func _draw() -> void:
	var font: Font = theme.get_font(&"normal_font", &"RichTextLabel")
	var font_size: int = theme.get_font_size(&"normal_font_size", &"RichTextLabel")
	var height: float = font.get_height(font_size)
	var target_lines: int = SettingsManager.current_settings.appearance.visible_lines
	
	var node := $VBoxContainer/Text
	node.custom_minimum_size.y = height * target_lines

func _init() -> void: 
	ObjectReferences.test_field_panel = self
	custom_minimum_size.x = SettingsManager.BASE_RESOLUTION.x / 1.50
	custom_minimum_size.y =  SettingsManager.BASE_RESOLUTION.y / 1.75

func _enter_tree() -> void: 
	print("Node: Setting up " + str(self))
	TextManager.connect_label($VBoxContainer/Text/RichTextLabel)
	TimerManager.connect_label($VBoxContainer/HBoxContainer/TimerLabel)
	TypingManager.connect_line_edit($VBoxContainer/HBoxContainer/LineEdit)
	
	visible = true

func _ready() -> void: StateMachine.change_state(StateMachine.State.NEW)

func get_line_edit() -> LineEdit: return $VBoxContainer/HBoxContainer/LineEdit
