extends Node

var timer: Timer = Timer.new()
var label : Label

var minute: int = 1
var second: int = 0

func _ready() -> void: 
	timer.connect("timeout", Callable.create(self, "_on_timer_timeout"))
	add_child(timer)

#region node connections
func connect_label(node: Label) -> void: 
	label = node
	_update_label()
#endregion

func get_time() -> float: return float(minute) + (float(second) / 60)

func new_test() -> void:
	timer.stop()
	minute = 1
	second = 0
	_update_label()

func start() -> void:
	timer.start()

func stop() -> void:
	timer.stop()
	minute = 1
	second = 0

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
