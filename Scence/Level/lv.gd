extends Label

var current_lv = ExpManager.current_lv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ExpManager.level_up.connect(on_lv_up)
	text = str(current_lv)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_lv_up(level):
	#print("label lv up")
	text = str(level)
