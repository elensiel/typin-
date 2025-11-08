extends VBoxContainer
class_name FontOption

var buttons: Array[Button]

func _ready() -> void:
	for child in $Content/VBoxContainer.get_children():
		if child is HBoxContainer:
			for button in child.get_children():
				buttons.append(button)
	
	_update_selection()
	
	for button in buttons:
		button.toggled.connect(Callable.create(self, &"_on_toggled").bind(button))

func _update_selection() -> void:
	for button in buttons:
		if button.get_theme_font(&"font") == ThemeManager.current_font:
			button.button_pressed = true
			return

func _on_toggled(toggled_on: bool, emitting_button: Button) -> void:
	if toggled_on:
		for button in buttons:
			if button.button_pressed and button != emitting_button:
				button.button_pressed = false
			
		var font := emitting_button.get_theme_font(&"font")
		ThemeManager.set_font(font)
