extends Node

var timer: Timer = Timer.new()
var label : Label

var minute: int = 1
var second: int = 0

func _enter_tree() -> void:
	timer.connect("timeout", Callable.create(self, "_on_timer_timeout"))
	add_child(timer)

#region node connections
func connect_label(node: Label) -> void: 
	print("TimerManager: Connecting Timer Label: " + str(node))
	label = node
	update_label()
#endregion

func get_time() -> float: return float(minute) + (float(second) / 60)

func new_test() -> void:
	timer.stop()
	minute = 1
	second = 0
	update_label()

func start() -> void: timer.start()

func stop() -> void:
	timer.stop()
	minute = 1
	second = 0

func update_label() -> void: label.text = &"%02d:%02d" % [minute, second]

func _on_timer_timeout() -> void:
	second -= 1
	
	if second < 0:
		if minute <= 0:
			return StateMachine.change_state(StateMachine.State.END)
		else:
			minute -= 1
		
		second = 59
	
	update_label()
