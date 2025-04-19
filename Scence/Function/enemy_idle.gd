# 定義State類別
extends State
class_name EnemyIdle

var timer = 5
@onready var animation_player = $"../../AnimationPlayer"


    
func enter():
    animation_player.play("idle_right")
    
    
func exit():
    pass  # 當退出該狀態時執行的代碼

func update(_delta):
    timer = timer - _delta
    if timer <= 0:
        print("go !")
        state_transition.emit(self, "EnemyWalk")

    
