extends RefCounted
class_name WordEvaluator

var _previous_typed_length: int

func is_typed_correct(typed: String, expected: String) -> bool:
	var length := typed.length() 
	var is_new_char := length > _previous_typed_length # if not backspaced
	var is_correct := length <= expected.length() and expected.begins_with(typed)
	
	if is_correct and is_new_char:
		ScoreManager.correct += 1
	elif is_new_char:
		ScoreManager.error += 1
	
	_previous_typed_length = length
	return is_correct

func is_word_correct(submitted: String, expected: String) -> bool:
	# record if user did not finish the word
	var delta := submitted.length() - expected.length()
	if delta < 0:
		ScoreManager.missed += -delta
	
	return submitted == expected
