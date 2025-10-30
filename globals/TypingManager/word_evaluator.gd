extends RefCounted
class_name WordEvaluator

func is_typed_correct(typed: String, expected: String) -> bool:
	if typed.length() <= expected.length() and expected.begins_with(typed):
		return true
	return false

func is_word_correct(submitted: String, expected: String) -> bool:
	if submitted == expected:
		return true
	return false
