extends Marker2D

@export var ray_to_mouse : RayCast2D
@export var bullet : PackedScene

# 子彈發射速率，單位秒
@export var shoot_rate : float = 0.1

var muzzle : Marker2D
var time_since_last_shot : float = 0.0

func _ready() -> void:
	# 初始化槍口位置
	muzzle = $Muzzle
	#pass

func _process(delta: float) -> void:
	# 更新物件的旋轉角度以指向滑鼠
	rotation = ray_to_mouse.angle
	
	# 增加從上次射擊以來的時間，也就是累計時間
	time_since_last_shot = time_since_last_shot + delta
	
	# 如果按下射擊且累計時間大於射擊限制就允許射擊子彈
	if Input.is_action_pressed("shoot") and time_since_last_shot >= shoot_rate:
		shoot_bullet()
		# 重置時間計數器
		time_since_last_shot = 0.0

	if Input.is_action_pressed("rate_up"):
		rate_up()
	else:
		shoot_rate = 0.1

# 負責生成和發射子彈的函數
func shoot_bullet() -> void:
	# 實例化子彈對象
	var bullet_instance : Node2D = bullet.instantiate()
	bullet_instance.position = muzzle.global_position  # 設定子彈初始位置
	bullet_instance.rotation = muzzle.global_rotation  # 設定子彈的旋轉角
	# 計算並設置子彈的速度, 使用normalized()是因為不想要向量的長度影響速度
	bullet_instance.velocity = ray_to_mouse.target_position.normalized() * 1000
	
	# 將子彈節點加入當前場景
	get_tree().current_scene.add_child(bullet_instance)
	
func rate_up():
	shoot_rate = 0.05
