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

#var correct_words: int = 0
#var wrong_words: int = 0
#endregion

func get_accuracy() -> float:
	var total: float = correct_keystrokes + wrong_keystrokes
	return (float(correct_keystrokes) / total) * 100

func get_raw_speed() -> float:
	var total_strokes: float = correct_keystrokes + wrong_keystrokes
	return (total_strokes / 5) / TimerManager.get_time()

func get_net_wpm() -> int: return roundi(get_raw_speed() * (get_accuracy() / 100))

func reset() -> void:
	correct_keystrokes = 0
	wrong_keystrokes = 0

func update_label() -> void:
	labels[0].text = str(get_net_wpm())
	labels[1].text = str(snappedf(get_accuracy(), 0.01)) + &"%"
	labels[2].text = str(roundi(get_raw_speed())) + &" WPM"
