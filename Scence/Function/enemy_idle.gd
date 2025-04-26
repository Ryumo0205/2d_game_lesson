# 定義State類別
extends State
class_name EnemyIdle

var timer = 2
@onready var animation_player = $"../../AnimationPlayer"
@onready var enemy = $"../.."
@onready var hitbox = $"../../HitBox"

    
func _ready() -> void:
    hitbox.area_entered.connect(on_hit)
    
func enter():
    if timer <= 0:
        timer = 2
    
    if enemy.look_right == true:
        animation_player.play("idle_right")
    if enemy.look_left == true:
        animation_player.play("idle_left")
    
    
func exit():
    pass  # 當退出該狀態時執行的代碼

func update(_delta):
    timer = timer - _delta
    if timer <= 0:
        state_transition.emit(self, "EnemyWalk")


func on_hit(area):
    enemy.is_hit = true
    enemy.current_hp = enemy.current_hp - 1
    #print("hp:",enemy.current_hp)
    SfxManager.play_hit_sfx()
    enemy.check_hp()
    state_transition.emit(self, "EnemyHit")
