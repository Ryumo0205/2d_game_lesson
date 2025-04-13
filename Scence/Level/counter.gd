extends Label
var died_enemy : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	died_enemy = 0 # Replace with function body.
	text = str(died_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
