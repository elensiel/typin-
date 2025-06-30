extends Node

enum State {
	NEW,
	TYPING,
	END,
	RESET,
	SETTINGS
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
		State.RESET:
			handle_reset()
		State.SETTINGS:
			handle_settings()

func handle_new() -> void:
	#region do not touch--ff must be in order
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.update_text()
	TextManager.scroll_update()
	#endregion
	
	TimerManager.new_test()
	NodeReferences.settings_panel.visible = false
	NodeReferences.wpm_panel.visible = false
	NodeReferences.test_field_panel.visible = true

func handle_typing() -> void:
	TimerManager.start()

func handle_end() -> void:
	TypingManager.stop_test()
	TimerManager.stop()
	ScoreManager.update_label()
	
	NodeReferences.test_field_panel.visible = false
	NodeReferences.wpm_panel.visible = true

func handle_reset() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	change_state(State.NEW)

func handle_settings() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	
	NodeReferences.test_field_panel.visible = false
	NodeReferences.wpm_panel.visible = false
	NodeReferences.settings_panel.visible = true
