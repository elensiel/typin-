extends Node

var timer : Timer
var label : RichTextLabel

var minute: int = 1
var second: int = 0

func connect_timer(node: Timer) -> void:
	timer = node
	timer.connect("timeout", Callable.create(self, "_on_timer_timeout"))

func connect_label(node: RichTextLabel) -> void:
	label = node
	_update_label()

func _update_label() -> void: label.text = "%02d:%02d" % [minute, second]

func _on_timer_timeout() -> void:
	second -= 1
	
	if second < 0:
		if minute <= 0:
			timer.stop()
			StateMachine.State.END
			return
		else:
			minute -= 1
		
		second = 59
	
	_update_label()
