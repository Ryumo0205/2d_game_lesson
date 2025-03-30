extends CharacterBody2D

# 角色朝向
var look_right : bool = true
var look_left : bool = false

# 移動速度
@export var speed: float = 200.0
# 引入動畫播放節點
@onready var animator : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

# 將所有輸入處理在 `_process` 或 `_physics_process`
func _process(delta: float) -> void:
	# 初始化方向變量
	var direction = Vector2.ZERO
	
	# 檢查按鍵輸入
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		look_right = false
		look_left = true
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		look_right = true
		look_left = false
		
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	
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
	
	
	# 設定移動方向與速度
	velocity = direction * speed
	
	# 移動玩家角色
	move_and_slide()
