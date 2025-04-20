extends Node



var current_db = 0
var master_bus_index = AudioServer.get_bus_index("Master")

@onready var gun_player = $gun_player
@onready var hit_player = $hit_player


func _ready() -> void:
	AudioServer.set_bus_volume_db(master_bus_index, current_db)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("db_up"):
		current_db = current_db + 1
		AudioServer.set_bus_volume_db(master_bus_index, current_db)
		print("up")
	if Input.is_action_just_pressed("db_down"):
		current_db = current_db - 1
		AudioServer.set_bus_volume_db(master_bus_index, current_db)
		print("down")

func play_gun_sfx():
	gun_player.play()
	
func play_hit_sfx():
	hit_player.play()
	
