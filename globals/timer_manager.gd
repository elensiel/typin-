extends Timer

var label: Label

var initial_seconds: int = 60
var seconds_remaining: int = initial_seconds

func _enter_tree() -> void:
	connect(&"timeout", Callable.create(self, &"_on_timeout"))

func connect_label(node: Label) -> void: 
	print("TimerManager: Connecting: " + str(node))
	label = node
	_update_label()

func reset() -> void:
	if !is_stopped():
		stop()
	
	seconds_remaining = initial_seconds
	_update_label()

func _update_label() -> void: label.text = str(seconds_remaining)

func _on_timeout() -> void:
	seconds_remaining -= 1
	if seconds_remaining <= 0:
		StateMachine.change_state(StateMachine.State.FINISHED)
	
	_update_label()
