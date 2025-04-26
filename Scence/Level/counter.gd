extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    text = str(0)
    ScoreManager.score_update.connect(on_score_update)
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func on_score_update(score):
    text = str(score)
