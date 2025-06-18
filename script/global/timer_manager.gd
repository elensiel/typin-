extends Node
#class_name TimerManager

var timer : Timer
var label : RichTextLabel

var minute: int = 1
var second: int = 0

#region node connections
func connect_label(node: RichTextLabel) -> void: label = node

func connect_timer(node: Timer) -> void:
	timer = node
	timer.connect("timeout", Callable.create(self, "_on_timer_timeout"))
#endregion

func new_test() -> void:
	timer.stop()
	minute = 1
	second = 0

func start() -> void:
	timer.start()

func stop() -> void:
	timer.stop()

func _update_label() -> void: label.text = "%02d:%02d" % [minute, second]

func _on_timer_timeout() -> void:
	second -= 1
	
	if second < 0:
		if minute <= 0:
			StateMachine.change_state(StateMachine.State.END)
			return
		else:
			minute -= 1
		
		second = 59
	
	_update_label()
