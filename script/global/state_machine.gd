extends Node
#class_name StateMachine

enum State {
	IDLE,
	TYPING,
	END,
}
var current_state: State = State.IDLE

func change_state(new_state) -> void: 
	current_state = new_state
	
	match current_state:
		State.IDLE:
			_handle_idle()
		State.TYPING:
			_handle_typing()
		State.END:
			_handle_end()

func _handle_idle() -> void:
	pass
	# idk what to put here for now
	# reset maybe

func _handle_typing() -> void:
	GlobalTimer.timer.start()

func _handle_end() -> void:
	pass
	# do wpm calc here
