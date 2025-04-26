extends State
class_name EnemyShoot

@onready var animation_player = $"../../AnimationPlayer"
@onready var enemy = $"../.."


@export var bullet_scene: PackedScene # 子彈預設名稱

func enter():

    pass

func exit():
    pass

func update(_delta):
    
    
    var player: Node2D = get_tree().current_scene.get_node("Player")
    if player == null:
        return
    shoot_bullet(player, _delta)
#

func shoot_bullet(player, _delta):
    if bullet_scene :
        var bullet = bullet_scene.instantiate()
        # 設定子彈初始位置
        bullet.global_position = enemy.global_position
        # 設定方向與速度（假設bullet有velocity變數，你要和自己的子彈腳本對齊）
       
        bullet.velocity = (player.global_position - enemy.global_position).normalized() * 3000 * _delta

        get_tree().current_scene.add_child(bullet) # 加入場景裡
    
    state_transition.emit(self, "EnemyIdle")
