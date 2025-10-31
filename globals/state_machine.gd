extends Node

enum State {
	NEW,
	TYPING,
	INTERRUPTED,
	FINISHED,
}

var current_state: State

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.NEW:
			_handle_new()
		State.TYPING:
			_handle_typing()
		State.FINISHED:
			_handle_finished()
	
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
	ObjectReferences.test_menu.visible = current_state != State.FINISHED
	ObjectReferences.result_menu.visible = current_state == State.FINISHED
