extends Node

var current_score
@export var win_screen_scene : PackedScene

signal score_update(current_score)



func _ready() -> void:
    current_score = 0
    score_update.connect(on_score_update)


func on_score_update(score):
    if score >= 100:
        win()

    
func win():
    print("win!")
    RankManager.load_from_file()
    RankManager.add_entry(current_score)
    
    var win_screen = win_screen_scene.instantiate()
    get_tree().current_scene.add_child(win_screen)
    
    RankManager.save_to_file()
    current_score = 0    
