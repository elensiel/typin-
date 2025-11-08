extends HBoxContainer
class_name QuickRestartOption

enum Option {
	OFF,
	ESC,
	TAB,
	ENTER
}

@onready var buttons: Array[Node] = $HBoxContainer.get_children()

func _ready() -> void:
	_update_selection()
	
	for button in buttons:
		button.toggled.connect(Callable.create(self, &"_on_toggled").bind(button))

func _update_selection() -> void:
	if not InputManager.shortcut_enabled:
		buttons[Option.OFF].button_pressed = true
		return
	
	match InputManager.shortcut_key:
		InputManager.ESC:
			buttons[Option.ESC].button_pressed = true
		InputManager.TAB:
			buttons[Option.TAB].button_pressed = true
		InputManager.ENTER:
			buttons[Option.ENTER].button_pressed = true

func _on_toggled(toggled_on: bool, emitting_button: Button) -> void:
	if toggled_on:
		for button in buttons:
			if button.button_pressed and button != emitting_button:
				button.button_pressed = false
		
		InputManager.set_shortcut_enabled(emitting_button != buttons[Option.OFF])
		
		if emitting_button == buttons[Option.ESC]:
			InputManager.set_shortcut_key(InputManager.ESC)
		elif emitting_button == buttons[Option.TAB]:
			InputManager.set_shortcut_key(InputManager.TAB)
		elif emitting_button == buttons[Option.ENTER]:
			InputManager.set_shortcut_key(InputManager.ENTER)
