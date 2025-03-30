extends Node2D
var velocity = Vector2.ZERO

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	# 每幀按方向和速度移動子彈
	position += velocity * delta
   
