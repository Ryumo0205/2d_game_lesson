extends Node

# 預加載敵人場景
@export var enemy_scene : PackedScene

# 獲取生成區域引用
@onready var collision_shape = get_node("../SpawnArea/CollisionShape2D") as CollisionShape2D

func _ready() -> void:
	print(collision_shape)
	$Timer.timeout.connect(_on_spawn_timer_timeout)

# 生成敵人的函數
func spawn_enemy():
	var player : CharacterBody2D = get_tree().current_scene.get_node("./Player")
	if not player :
		return
	# 最多嘗試的次數
	var max_times = 10
	
	for i in range(max_times) :
		
		# 獲取Area2D的CollisionShape2D
		var shape = collision_shape.shape as Shape2D
		# 根據形狀類型獲取隨機位置
		var random_position = Vector2.ZERO
		# shape的範圍中心
		var shape_size = shape.size / 2
		var shape_center = collision_shape.global_position
		random_position = Vector2(
			randf_range(-shape_size.x, shape_size.x),
			randf_range(-shape_size.y, shape_size.y)
		)
		random_position = random_position + shape_center
		
		var to_player_range = (player.global_position - random_position).length()
		if to_player_range > 100 :
			var enemy : CharacterBody2D = enemy_scene.instantiate()
			enemy.global_position = random_position
			get_tree().current_scene.add_child(enemy)
			break
		else:
			continue
		
func _on_spawn_timer_timeout():
	spawn_enemy()
