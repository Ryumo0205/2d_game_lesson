extends CharacterBody2D

var max_hp = 10
var current_hp : int
# 角色朝向
var look_right : bool = true
var look_left : bool = false
var is_hit : bool = false

# 移動速度
@export var speed: float = 200.0
# 引入動畫播放節點
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var hitbox = $HitBox
@onready var hp_bar = $ProgressBar

var right_vector = Vector2(1, 0)
@onready var ray_cast = $RayCast2D


func _ready() -> void:
    current_hp = max_hp
    hp_bar.value = current_hp
    hitbox.area_entered.connect(on_area_entered)
    animator.animation_finished.connect(on_anim_finished)

# 將所有輸入處理在 `_process` 或 `_physics_process`
func _process(delta: float) -> void:
    # 初始化方向變量
    var direction = Vector2.ZERO
    var dot_product = ray_cast.target_position.normalized().dot(right_vector)
    
    if dot_product > 0:
        look_right = true
        look_left = false
    if dot_product < 0:
        look_left = true
        look_right = false
    # 檢查按鍵輸入
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
        #look_right = false
        #look_left = true
    if Input.is_action_pressed("ui_right"):
        direction.x += 1
        #look_right = true
        #look_left = false
        
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1

    if is_hit == false:
    
        # 如果有輸入，歸一化方向向量，防止對角移動更快
        if direction != Vector2.ZERO:
        
            direction = direction.normalized()
            # 如果角色有動就依據方向播放跑步
            if look_left == true :
                animator.play("run_left")
            elif look_right == true:
                animator.play("run_right")
        # 角色沒動就依據方向播放待機
        if direction == Vector2.ZERO:
            if look_left == true :
                animator.play("idle_left")
            elif look_right == true:
                animator.play("idle_right")
    else:
        animator.play("hit")
    
    # 設定移動方向與速度
    velocity = direction * speed
    
    # 移動玩家角色
    move_and_slide()

func on_area_entered(area:Area2D):
    # 被擊中
    is_hit = true
    current_hp = current_hp - 1
    print("hp : ", current_hp)
    check_hp()
    
func check_hp():
    hp_bar.value = current_hp
    if current_hp <= 0:
        print("died")
        queue_free()
    
func on_anim_finished(anim):
    if anim == "hit" :
        is_hit = false
        print("animation finished")
