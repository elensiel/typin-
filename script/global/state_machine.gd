extends Node

enum State {
	NEW,
	TYPING,
	INTERRUPTED,
	END,
	SETTINGS,
}
var current_state: State = State.NEW

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.NEW:
			handle_new()
		State.TYPING:
			handle_typing()
		State.INTERRUPTED:
			pass
		State.END:
			handle_end()
		State.SETTINGS:
			handle_settings()
	
	handle_visibility()

func handle_new() -> void:
	#region do not touch--ff must be in order
	TimerManager.stop()
	ScoreManager.reset()
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.update_text()
	TextManager.scroll_update()
	#endregion
	TimerManager.new_test()
	
	if ObjectReferences.settings_panel != null:
		ObjectReferences.settings_panel.queue_free()
		ObjectReferences.settings_panel = null

func handle_typing() -> void: TimerManager.start()

func handle_end() -> void:
	TypingManager.stop_test()
	TimerManager.stop()
	ScoreManager.update_label()

func handle_settings() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	
	var instance := ObjectReferences.SETTINGS_PANEL_SCENE.instantiate()
	ObjectReferences.main.add_child(instance)

func handle_visibility() -> void:
	ObjectReferences.test_field_panel.visible = (current_state == State.NEW) || (current_state == State.TYPING) || (current_state == State.INTERRUPTED)
	ObjectReferences.wpm_panel.visible = current_state == State.END
	ObjectReferences.ui_container.update_ui()
