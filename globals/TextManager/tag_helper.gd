extends Node
class_name TagHelper

const COLOR: Dictionary[String, String] = {
	"correct": "dimgray",
	"typo": "peru"
}

func draw_background_correct(word: String) -> String:
	return &"[bgcolor=%s]%s[/bgcolor]" % [COLOR.correct, word]

func draw_background_typo(word: String) -> String:
	return &"[bgcolor=%s]%s[/bgcolor]" % [COLOR.typo, word]

func draw_underline(word: String) -> String:
	return &"[u]%s[/u]" % [word]
