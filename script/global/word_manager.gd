extends Node
#class_name WordManager

var current_text: Array[String] = []
var current_word : String

func get_common_words() -> Array[String]:
	for i in range(50):
		current_text.append(Words.common_words.pick_random())
	return current_text
