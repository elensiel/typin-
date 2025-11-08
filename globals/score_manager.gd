extends Node

enum Metric {
	NET_WPM,
	ACCURACY,
	RAW_SPEED
}

var labels: Array[Label] = [ null, null, null ]

var correct: int = 0
var error: int = 0
var missed: int = 0

func _get_accuracy() -> float:
	var total: float = correct + error + missed
	return (float(correct) / total) * 100

func _get_net_wpm() -> int:
	return roundi(_get_raw_speed() * (_get_accuracy() / 100))

func _get_raw_speed() -> float:
	var total: float = correct + error + missed
	var duration_in_minutes: float = float(TimerManager.initial_seconds) / 60
	return (total / 5) / duration_in_minutes

func reset() -> void:
	correct = 0
	error = 0
	missed = 0

func update_labels() -> void:
	labels[Metric.NET_WPM].text = str(_get_net_wpm())
	labels[Metric.ACCURACY].text = str(snappedf(_get_accuracy(), 0.01)) + &"%"
	labels[Metric.RAW_SPEED].text = str(roundi(_get_raw_speed())) + &"wpm"
