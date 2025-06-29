extends Node

const TEST_FIELD_NAME: StringName = &"test_field.tres"
var test_field: Theme = load_theme(TEST_FIELD_NAME)

func create_theme(file_name: StringName) -> Theme:
	var new_theme := Theme.new()
	
	var misc_font_size: int = 30
	var margin: int = 5
	
	new_theme.set_constant("margin_left", "MarginContainer", margin)
	new_theme.set_constant("margin_right", "MarginContainer", margin)
	new_theme.set_font_size("font_size", "Label", misc_font_size)
	new_theme.set_font_size("font_size", "LineEdit", misc_font_size)
	new_theme.set_font_size(&"normal_font_size", &"RichTextLabel", SettingsManager.DEFAULT_SETTINGS.general.font_size)
	new_theme.set_stylebox("panel", "PanelContainer", StyleBoxEmpty.new())
	
	ResourceSaver.save(new_theme, ensure_directory() + file_name)
	return new_theme

func ensure_directory() -> String:
	var directory: String = OS.get_user_data_dir() + &"/config/"
	if !DirAccess.dir_exists_absolute(directory):
		var error = DirAccess.make_dir_absolute(directory)
		if error == OK:
			print("ThemeManager: Created settings directory: " + directory)
		else:
			printerr("ThemeManager Error: Failed to create settings directory (Error: " + error_string(error) + "): " + directory)
	return directory

func load_theme(file_name: StringName) -> Theme:
	var file_path: String = ensure_directory() + file_name
	var resource: Theme = ResourceLoader.load(file_path)
	
	if resource:
		return resource
	return create_theme(file_name)

func save_theme(default: bool = false) -> void:
	var font_size: int = SettingsManager.changed_settings.general.font_size if !default else SettingsManager.DEFAULT_SETTINGS.general.font_size
	test_field.set_font_size(&"normal_font_size", &"RichTextLabel", font_size)
	ResourceSaver.save(test_field, ensure_directory() + TEST_FIELD_NAME)
