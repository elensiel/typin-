extends Node

enum State {
	NEW,
	TYPING,
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
		State.END:
			handle_end()
		State.SETTINGS:
			handle_settings()

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
	ObjectReferences.settings_panel = null
	
	ObjectReferences.wpm_panel.visible = false
	
	ObjectReferences.ui_container.show_ui()
	ObjectReferences.test_field_panel.visible = true
	

func handle_typing() -> void:
	TimerManager.start()
	ObjectReferences.ui_container.hide_ui()

func handle_end() -> void:
	TypingManager.stop_test()
	TimerManager.stop()
	ScoreManager.update_label()
	
	ObjectReferences.test_field_panel.visible = false
	
	ObjectReferences.wpm_panel.visible = true
	ObjectReferences.ui_container.show_ui()

func handle_settings() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	
	var instance := ObjectReferences.SETTINGS_PANEL_SCENE.instantiate()
	ObjectReferences.main.add_child(instance)
	
	ObjectReferences.test_field_panel.visible = false
	ObjectReferences.wpm_panel.visible = false
	ObjectReferences.ui_container.hide_ui()
