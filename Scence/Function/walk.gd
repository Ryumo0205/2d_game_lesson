# 定義State類別
extends State
class_name EnemyWalk


@onready var animation_player = $"../../AnimationPlayer"
#var is_hit = false
@onready var enemy = $"../.."
@onready var hitbox = $"../../HitBox"


func _ready() -> void:
    #hitbox.area_entered.connect(on_hit)
    pass

func enter():
    pass  # 當進入該狀態時執行的代碼

func exit():
    pass  # 當退出該狀態時執行的代碼

func update(_delta):
    var player: Node2D = get_tree().current_scene.get_node("Player")  # 確保路徑正確
    var direction = Vector2.ZERO
    var range : float
    
    if player == null :
        return
        
    if enemy.is_hit == true :
        if enemy.look_right == true:
            animation_player.play("hit_right")
            return
        if enemy.look_left == true:
            animation_player.play("hit_left")
            return
    
    
    # 計算方向向量（從敵人到玩家）
    direction = (player.global_position - enemy.global_position).normalized()
    range = (player.global_position - enemy.global_position).length()
    
    var fsm = $".."
    if range < 100 :
        
        if fsm.states_dict.has("EnemyShoot".to_lower()):
            state_transition.emit(self, "EnemyShoot")
    if range < 60 :
    
        if fsm.states_dict.has("EnemyDash".to_lower()):
            state_transition.emit(self, "EnemyDash")
            
            
            
    which_side(direction)
    # 使用 CharacterBody2D 的 move_and_slide() 方法移動敵人
    if enemy.look_right == true:
        animation_player.play("run_right")
    if enemy.look_left == true:
        animation_player.play("run_left")
    
    enemy.velocity = direction * enemy.speed
    enemy.move_and_slide()
    
func which_side(direction):
    if direction.x > 0 :
        enemy.look_right = true
        enemy.look_left = false
    
    if direction.x < 0 :
        enemy.look_right = false
        enemy.look_left = true
        
        
