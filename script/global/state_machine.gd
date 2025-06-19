extends Node
#class_name StateMachine

var wpm_panel : PanelContainer
var test_field : VBoxContainer

enum State {
	NEW,
	TYPING,
	END,
	RESET,
}
var cur_state: State = State.NEW

func change_state(new_state: State) -> void:
	cur_state = new_state
	
	match cur_state:
		State.NEW:
			_handle_new()
		State.TYPING:
			_handle_typing()
		State.END:
			_handle_end()
		State.RESET:
			_handle_reset()

func _handle_new() -> void:
	#region do not touch--the ff must be in order
	TextManager.new_text()
	TypingManager.new_test()
	TextManager.update_text()
	TextManager.scroll_update()
	#endregion
	
	TimerManager.new_test()
	wpm_panel.visible = false
	test_field.visible = true

func _handle_typing() -> void:
	TimerManager.start()

func _handle_end() -> void:
	TypingManager.stop_test()
	TimerManager.stop()
	ScoreManager.update_label()
	
	test_field.visible = false
	wpm_panel.visible = true

func _handle_reset() -> void:
	TimerManager.stop()
	ScoreManager.reset()
	change_state(State.NEW)
