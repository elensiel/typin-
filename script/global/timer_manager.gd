extends Node

var timer: Timer = Timer.new()
var label : Label

var initial_minute: int = 1
var initial_second: int = 0
var minute: int = 1
var second: int = 0

func _enter_tree() -> void:
	timer.connect("timeout", Callable.create(self, "_on_timer_timeout"))
	add_child(timer)

#region node connections
func connect_label(node: Label) -> void: 
	print("TimerManager: Connecting Timer Label: " + str(node))
	label = node
	_update_label()
#endregion

func get_time() -> float: return float(initial_minute) + (float(initial_second) / 60)

func start() -> void: if timer.is_stopped(): timer.start()
func stop() -> void: if !timer.is_stopped(): timer.stop()
func reset() -> void:
	if !timer.is_stopped(): 
		timer.stop()
	
	minute = initial_minute
	second = initial_second
	_update_label()

func _update_label() -> void: label.text = &"%02d:%02d" % [minute, second]

func _on_timer_timeout() -> void:
	second -= 1
	
	if minute <= 0 && second < 0:
		return StateMachine.change_state(StateMachine.State.DONE)
	elif second < 0:
		minute -= 1
		second = 59
	
	_update_label()
