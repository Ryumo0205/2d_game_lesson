extends Node

# 匯入要生成的敵人 PackedScene 陣列，可在 Inspector 自行配置
@export var enemy_scene_array : Array[PackedScene]
# 預先取得碰撞區域的 CollisionShape2D 節點
@onready var collision_shape = get_node("../SpawnArea/CollisionShape2D") as CollisionShape2D

var is_game_start = false

# 不同等級對應的敵人生成權重
var enemy_weights_by_level = [
    [0.9, 0.0, 0.0, 0.1],    # 等級小於3時，只有第0和第3種敵人有機會出現
    [0.5, 0.4, 0.0, 0.1],    # 等級3~6，只有第0、1和3種敵人有機會出現
    [0.4, 0.3, 0.2, 0.1]     # 等級7以上，四種敵人都可能出現
]

func _ready() -> void:
    # 連接 Timer 的 timeout 訊號至生成敵人的函式
    $Timer.timeout.connect(_on_spawn_timer_timeout)
    update_spawn_rate()

# 權重選擇函式，根據權重陣列隨機挑選敵人種類，回傳選中的索引
func pick_weighted_enemy(weights : Array) -> int:
    var total = 0.0
    for w in weights:
        total += w
    var r = randf_range(0, total)
    var acc = 0.0
    for i in weights.size():
        acc += weights[i]
        if r < acc:
            return i
    return 0 # 安全回傳，理論上不會發生

# 根據當前等級回傳對應的權重陣列
func get_current_weights(level: int) -> Array:
    if level < 3:
        return enemy_weights_by_level[0]
    elif level < 5:
        return enemy_weights_by_level[1]
    else:
        return enemy_weights_by_level[2]

# 生成一隻敵人
func spawn_enemy():
    var player : CharacterBody2D = get_tree().current_scene.get_node("./Player") # 取得玩家節點
    if not player:
        return
    var max_times = 10 # 最多嘗試10次以找到合適位置
    var weights = get_current_weights(ExpManager.current_lv) # 取得權重資料
    for i in range(max_times):
        var shape = collision_shape.shape as Shape2D
        var shape_size = shape.size / 2   # 取得形狀（尺寸的一半，方便算出範圍）
        var shape_center = collision_shape.global_position # 取得生成中心
        var random_position = Vector2(
            randf_range(-shape_size.x, shape_size.x),
            randf_range(-shape_size.y, shape_size.y)
        ) + shape_center                     # 隨機產生一個在碰撞區域中的座標
        var to_player_range = (player.global_position - random_position).length() # 計算與玩家距離
        if to_player_range > 100: # 若與玩家距離大於100再生成
            var enemy_index = pick_weighted_enemy(weights) # 根據權重隨機選一種敵人
            var enemy = enemy_scene_array[enemy_index].instantiate() # 生成敵人實例
            enemy.global_position = random_position # 設定生成位置
            get_tree().current_scene.add_child(enemy) # 加入當前場景
            break

func update_spawn_rate():
    var level = ExpManager.current_lv
    var new_wait_time = max(0.5, 3.0 - level * 0.3)
    $Timer.wait_time = new_wait_time

func _on_spawn_timer_timeout():
    if is_game_start == true:
        spawn_enemy()
        update_spawn_rate() # 每當生成時重新調整間隔
