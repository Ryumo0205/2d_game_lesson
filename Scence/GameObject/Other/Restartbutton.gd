extends Button



func _ready() -> void:
    button_down.connect(on_button_down)
    
    

func on_button_down():
    get_tree().reload_current_scene()
