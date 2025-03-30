extends Camera2D

#@export var player: CharacterBody2D  # 從外部連結 Player 節點路徑
@export var smoothing_speed: float = 5.0  # 平滑跟隨的速度
@onready var player = $"../Player"

func _ready():
	pass

func _process(delta):
	if player:
		# 平滑移動攝影機到玩家的位置
		global_position = lerp(global_position, player.global_position, smoothing_speed * delta)
	else:
		return
