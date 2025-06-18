extends Node
#class_name StateMachine

enum State {
	NEW,
	TYPING,
	END,
	RESET,
}
var cur_state: State = State.NEW

func change_state(new_state: State) -> void:
	cur_state = new_state
	
	match cur_state:
		State.NEW:
			_handle_new()
		State.TYPING:
			_handle_typing()
		State.END:
			_handle_end()
		State.RESET:
			_handle_reset()

func _handle_new() -> void:
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.update_text()

func _handle_typing() -> void:
	TimerManager.start()

func _handle_end() -> void:
	TypingManager.stop_test()
	TimerManager.stop()

func _handle_reset() -> void:
	pass
