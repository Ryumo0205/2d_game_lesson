extends Button


@export var spawn_manager : Node
@onready var startmenu = $"../.."

func _ready() -> void:
    pass
    button_down.connect(on_button_down)
    
    
func on_button_down():
    print("start")
    spawn_manager.is_game_start = true
    disabled = true
    startmenu.visible = false
