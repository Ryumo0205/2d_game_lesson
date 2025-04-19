extends Marker2D

@export var ray_to_mouse : RayCast2D
@export var bullet : PackedScene

# 子彈發射速率，單位秒
@export var shoot_rate : float 

var muzzle : Marker2D
var time_since_last_shot : float = 0.0
var right_vector = Vector2(1, 0)

var guns : Array = ["res://Assets/guns/Icon29_07.png", 
                    "res://Assets/guns/Icon29_11.png", 
                    "res://Assets/guns/Icon29_16.png",
                    "res://Assets/guns/Icon29_21.png",
                    "res://Assets/guns/Icon29_26.png",
                    ]
var guns_index = 0

func _ready() -> void:
    # 初始化槍口位置
    muzzle = $Muzzle
    ExpManager.level_up.connect(weapon_update)

func _process(delta: float) -> void:
    # 更新物件的旋轉角度以指向滑鼠
    rotation = ray_to_mouse.angle
    
    # 為了判斷朝向, 計算點積
    var dot_product = ray_to_mouse.target_position.normalized().dot(right_vector)

    if dot_product > 0 :
        scale.y = 1
    if dot_product < 0 :
        scale.y = -1
    
    # 增加從上次射擊以來的時間，也就是累計時間
    time_since_last_shot = time_since_last_shot + delta
    
    # 如果按下射擊且累計時間大於射擊限制就允許射擊子彈
    if Input.is_action_pressed("shoot") and time_since_last_shot >= shoot_rate:
        shoot_bullet()
        # 重置時間計數器
        time_since_last_shot = 0.0


# 負責生成和發射子彈的函數
func shoot_bullet() -> void:
    # 實例化子彈對象
    var bullet_instance : Node2D = bullet.instantiate()
    bullet_instance
    bullet_instance.position = muzzle.global_position  # 設定子彈初始位置
    bullet_instance.rotation = muzzle.global_rotation  # 設定子彈的旋轉角
    # 計算並設置子彈的速度, 使用normalized()是因為不想要向量的長度影響速度
    bullet_instance.velocity = ray_to_mouse.target_position.normalized() * 1000
    SfxManager.play_gun_sfx()
    
    # 將子彈節點加入當前場景
    get_tree().current_scene.add_child(bullet_instance)
    
func weapon_update(_level):
    print("weapon lv: ", guns_index)
    if guns_index >= 4 :
        return
        
    guns_index = guns_index + 1
    var texture_res = load(guns[guns_index])
    $Sprite2D.texture = texture_res
    shoot_rate = shoot_rate - 0.03
