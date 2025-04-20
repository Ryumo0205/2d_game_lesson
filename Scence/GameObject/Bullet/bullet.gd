extends Node2D
var velocity = Vector2.ZERO
@onready var hitbox = $HitBox

var bullet_time = 0.05

func _ready() -> void:
	hitbox.area_entered.connect(on_hit)
	hitbox.body_entered.connect(on_hit_wall)
	
func _process(delta: float) -> void:
	# 每幀按方向和速度移動子彈
	position += velocity * delta
	
   
func on_hit(area:Area2D):
	if area.collision_layer == 2 :
		pass

func on_hit_wall(body):
	queue_free()
	
