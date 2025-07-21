extends Node

"""
0 : netwpm
1 : acc
2 : rawspd
"""
var labels: Array[Label] = [null, null, null]

#region user typing data
var correct_keystrokes: int = 0
var wrong_keystrokes: int = 0
#endregion

func _get_accuracy() -> float:
	var total_keystrokes: float = correct_keystrokes + wrong_keystrokes
	return (float(correct_keystrokes) / total_keystrokes) * 100

func _get_raw_speed() -> float:
	var total_keystrokes: float = correct_keystrokes + wrong_keystrokes
	return (total_keystrokes / 5) / TimerManager.get_time()

func _get_net_wpm() -> int: return roundi(_get_raw_speed() * (_get_accuracy() / 100))

func reset() -> void:
	correct_keystrokes = 0
	wrong_keystrokes = 0

func update_label() -> void:
	labels[0].text = str(_get_net_wpm())
	labels[1].text = str(snappedf(_get_accuracy(), 0.01)) + &"%"
	labels[2].text = str(roundi(_get_raw_speed())) + &" WPM"
