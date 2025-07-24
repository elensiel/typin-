extends Node

enum State {
	NEW,
	TYPING,
	INTERRUPTED,
	DONE,
	SETTINGS,
}
var current_state: State = State.NEW

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.NEW:
			_handle_new()
		State.TYPING:
			_handle_typing()
		State.INTERRUPTED:
			_handle_interrupted()
		State.DONE:
			_handle_done()
		State.SETTINGS:
			_handle_settings()
	
	_handle_visibility()

func _handle_new() -> void:
	#region do not touch -- the ff must be in order
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.update_text()
	TextManager.scroll_update()
	#endregion
	
	TimerManager.reset()
	ScoreManager.reset()
	
	if ObjectReferences.settings_panel != null:
		ObjectReferences.settings_panel.queue_free()
		ObjectReferences.settings_panel = null

func _handle_typing() -> void: 
	TimerManager.start()

func _handle_interrupted() -> void:
	pass

func _handle_done() -> void:
	#TypingManager.stop_test()
	TimerManager.stop()
	ScoreManager.update_label()

func _handle_settings() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	
	var instance := ObjectReferences.SETTINGS_PANEL_SCENE.instantiate()
	ObjectReferences.main.add_child(instance)

func _handle_visibility() -> void:
	ObjectReferences.test_field_panel.visible = (current_state == State.NEW) || (current_state == State.TYPING) || (current_state == State.INTERRUPTED)
	ObjectReferences.wpm_panel.visible = current_state == State.DONE
	ObjectReferences.ui_container.update_ui()
