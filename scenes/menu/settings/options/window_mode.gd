class_name WindowModeOption extends HBoxContainer

@onready var option_button: OptionButton = $OptionButton

func _ready() -> void:
	_load_previous()

func _load_previous() -> void:
	for i in option_button.item_count:
		if option_button.get_item_id(i) == SettingsManager.current_settings.general.window_mode:
			option_button.select(i)
			option_button.item_selected.emit(i)

func set_window_mode(mode: int) -> void:
	if DisplayServer.window_get_mode() == mode:
		return
	
	DisplayServer.window_set_mode(mode)
	SettingsManager.save_changes()

func _on_option_button_item_selected(index: int) -> void:
	set_window_mode(option_button.get_item_id(index))
