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
    # 為了區隔, 所以讓敵人子彈旋轉
    $Sprite2D.rotation = $Sprite2D.rotation + 20 * delta
    
   
func on_hit(area:Area2D):
    if area.collision_layer == 1 :
        queue_free()

func on_hit_wall(body):
    queue_free()
