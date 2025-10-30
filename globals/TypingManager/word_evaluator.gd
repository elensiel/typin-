extends RefCounted
class_name WordEvaluator

var current_typed_length: int

func is_typed_correct(typed: String, expected: String) -> bool:
	var length := typed.length() 
	current_typed_length = length
	
	return length <= expected.length() and expected.begins_with(typed)

func is_word_correct(submitted: String, expected: String) -> bool:
	if submitted == expected:
		return true
	return false
