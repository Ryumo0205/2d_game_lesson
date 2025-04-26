extends State
class_name EnemyDash

@onready var animation_player = $"../../AnimationPlayer"
@onready var enemy = $"../.."

var dash_direction := Vector2.ZERO
var dash_speed := 100.0    # 突進速度（可自行調整）
var dash_duration := 1  # 突進持續秒數
var dash_timer := 0.0

func enter():
    var player: Node2D = get_tree().current_scene.get_node("Player")
    if player == null:
        # 若沒找到玩家，回到Idle
        state_transition.emit(self, "EnemyIdle")
        return
    
    # 計算面向玩家的方向
    dash_direction = (player.global_position - enemy.global_position).normalized()
    dash_timer = dash_duration
    
    # 更改動畫 (根據你的動畫命名，自行調整)
    which_side(dash_direction)
    if enemy.look_right:
        animation_player.play("run_right")
    elif enemy.look_left:
        animation_player.play("run_left")

func exit():
    # 重設敵人速度
    enemy.velocity = Vector2.ZERO

func update(_delta):
    if dash_timer > 0:
        # 快速移動 (速度 * 方向)
        enemy.velocity = dash_direction * dash_speed
        enemy.move_and_slide()  # 根據你的敵人腳本
        dash_timer -= _delta
    else:
        # 突進結束回到Idle
        state_transition.emit(self, "EnemyIdle")

func which_side(direction: Vector2):
    if direction.x > 0:
        enemy.look_right = true
        enemy.look_left = false
    elif direction.x < 0:
        enemy.look_right = false
        enemy.look_left = true
