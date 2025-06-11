extends Node
#class_name WordManager

func get_common_words() -> String:
	var text: String = ""
	for i in range(50):
		text += Words.common_words.pick_random() + " "
	return text
