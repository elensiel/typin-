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

func _handle_new() -> void:
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.render_text()

func _handle_typing() -> void:pass
	#TimerManager.start()
