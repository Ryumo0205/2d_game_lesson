extends Node


signal exp_update
signal level_up(level:int)
var current_lv = 1
var current_exp = 0
var max_exp = 10
var times = 1.2


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func check_exp():
	exp_update.emit()
	if current_exp >= max_exp:
		print("manager lv up")
		current_lv = current_lv + 1
		level_up.emit(current_lv)
		max_exp = max_exp * times
		current_exp = 0
