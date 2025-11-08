extends VBoxContainer

var buttons: Array[Button]

func _ready() -> void:
	for child in get_children():
		if child is HBoxContainer:
			for button in child.get_children():
				buttons.append(button)
	
	for button in buttons:
		button.toggled.connect(Callable.create(self, &"_on_toggled").bind(button))

func _on_toggled(toggled_on: bool, emitting_button: Button) -> void:
	if toggled_on:
		for button in buttons:
			if button.button_pressed and button != emitting_button:
				button.button_pressed = false
			
		var font := emitting_button.get_theme_font(&"font")
		ThemeManager.set_font(font)
