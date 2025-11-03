extends Node

enum State {
	NEW,
	TYPING,
	INTERRUPTED,
	FINISHED,
	SETTINGS,
}

var current_state: State

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.NEW:
			_handle_new()
		State.TYPING:
			_handle_typing()
		State.INTERRUPTED:
			pass
		State.FINISHED:
			_handle_finished()
		State.SETTINGS:
			pass
	
	_handle_visibility()

func _handle_new() -> void:
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.render_on_type()
	TextManager.scroll_update()
	TimerManager.reset()
	ScoreManager.reset()

func _handle_typing() -> void:
	TimerManager.start()

func _handle_finished() -> void:
	TimerManager.stop()
	ScoreManager.update_labels()

func _handle_visibility() -> void:
	# MENUS
	ObjectReferences.test_menu.visible = current_state != State.FINISHED and current_state != State.SETTINGS
	ObjectReferences.result_menu.visible = current_state == State.FINISHED
	ObjectReferences.settings_menu.visible = current_state == State.SETTINGS
	
	# BUTTONS
	ObjectReferences.restart_button.visible = !InputManager.shortcut_enabled and current_state != State.SETTINGS
	# hide settings button while typing
	ObjectReferences.settings_button.visible = current_state != State.SETTINGS and current_state != State.TYPING
	
	# CURSOR
	# hides cursor while typing
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN if current_state == State.TYPING else Input.MOUSE_MODE_VISIBLE
