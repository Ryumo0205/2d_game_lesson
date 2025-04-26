extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    value = ExpManager.current_exp
    ExpManager.exp_update.connect(on_exp_update)
    ExpManager.level_up.connect(on_level_up)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func on_exp_update():
    value = ExpManager.current_exp
    
    
func on_level_up(level):
    #print(ExpManager.current_exp)
    value = ExpManager.current_exp
    max_value = ExpManager.max_exp
    
    
