# 定義State類別
extends State
class_name EnemyWalk

var look_left = false
var look_right = true
@onready var animation_player = $"../../AnimationPlayer"
var is_hit = false
@onready var enemy = $"../.."


func enter():
    pass  # 當進入該狀態時執行的代碼

func exit():
    pass  # 當退出該狀態時執行的代碼

func update(_delta):
    var player: Node2D = get_tree().current_scene.get_node("Player")  # 確保路徑正確
    var direction = Vector2.ZERO
    
    if player == null :
        return
        
    if is_hit == true :
        if look_right == true:
            animation_player.play("hit_right")
            return
        if look_left == true:
            animation_player.play("hit_left")
            return
    
    
    # 計算方向向量（從敵人到玩家）
    direction = (player.global_position - enemy.global_position).normalized()
    which_side(direction)
    # 使用 CharacterBody2D 的 move_and_slide() 方法移動敵人
    if look_right == true:
        animation_player.play("run_right")
    if look_left == true:
        animation_player.play("run_left")
    
    enemy.velocity = direction * enemy.speed
    enemy.move_and_slide()
    
func which_side(direction):
    if direction.x > 0 :
        look_right = true
        look_left = false
    
    if direction.x < 0 :
        look_right = false
        look_left = true
