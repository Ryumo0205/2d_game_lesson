extends State
class_name EnemyHit

@onready var animation_player = $"../../AnimationPlayer"
@onready var enemy = $"../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    animation_player.animation_finished.connect(on_ani_finished)

    pass # Replace with function body.


func update(_dalta):
    if enemy.look_right == true:
        animation_player.play("hit_right")
        return
    if enemy.look_left == true:
        animation_player.play("hit_left")
        return
        
        
func on_ani_finished(anim):
    if anim == "hit_right" or anim == "hit_left":
        enemy.is_hit = false
        state_transition.emit(self, "EnemyWalk")
        #if enemy.look_right == true:
            #state_transition.emit(self, "EnemyWalk")
        #if enemy.look_left == true:
            #state_transition.emit(self, "EnemyWalk")
    
