extends Node
#class_name ScoreManager

var label : RichTextLabel

#region user typing data
var correct_keystrokes: int = 0
var wrong_keystrokes: int = 0

#var correct_words: int = 0
#var wrong_words: int = 0
#endregion

func connect_label(node: RichTextLabel) -> void: label = node

func get_accuracy() -> float:
	var total: float = correct_keystrokes + wrong_keystrokes
	return (float(correct_keystrokes) / total) * 100

func get_raw_speed() -> float:
	var total_strokes: float = correct_keystrokes + wrong_keystrokes
	
	return (total_strokes / 5) / TimerManager.get_time()

func get_net_wpm() -> int:
	return roundi(get_raw_speed() * (get_accuracy() / 100))

func reset() -> void:
	correct_keystrokes = 0
	wrong_keystrokes = 0

func update_label() -> void:
	label.text = ""
	label.append_text("WPM:\t" + str(get_net_wpm()))
	label.append_text("\nAccuracy:\t" + str(snapped(get_accuracy(), 0.01)) + "%")
	label.append_text("\nRaw Speed:\t" + str(roundi(get_raw_speed())))
