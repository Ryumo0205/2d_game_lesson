extends RayCast2D

# 假設 RayCast2D 是此 Node2D 的子節點
var angle : float

func _ready():
	# 確保 RayCast2D 始終啟用
	enabled = true

func _process(delta):
	# 獲取滑鼠在視窗中的全局位置
	var mouse_position = get_global_mouse_position()
	
	# 計算從 RayCast2D 的位置到滑鼠位置的方向
	var direction = (mouse_position - global_position)
	angle = direction.angle()
	# 將 RayCast2D 的 cast_to 屬性設置為指向滑鼠位置
	target_position = direction  
