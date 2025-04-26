extends CharacterBody2D  # 假設你的敵人是 CharacterBody2D 節點

@export var speed: float = 50.0  # 調整敵人移動速度
@export var max_hp : int
@onready var animation_player = $AnimationPlayer
@onready var hit_box = $HitBox
@onready var ui_counter : Label = get_tree().current_scene.get_node("./UI_Layer/MarginContainer/score")
@onready var hp_bar = $VBoxContainer/ProgressBar

var current_hp
var look_left = false
var look_right = true
var is_hit = false

func _ready() -> void:
    current_hp = max_hp
    #hit_box.area_entered.connect(on_hit)
    animation_player.animation_finished.connect(on_ani_finished)
    

func _process(delta: float) -> void:
    pass

    
func on_ani_finished(anim):
    if anim == "hit_right" or anim == "hit_left":
        is_hit = false
        
        if look_right == true:
            animation_player.play("idle_right")
        if look_left == true:
            animation_player.play("idle_left")

func check_hp():
    hp_bar.value = current_hp
    if current_hp <= 0:
        ScoreManager.current_score = ScoreManager.current_score + 100
        ScoreManager.score_update.emit(ScoreManager.current_score)
        
        ExpManager.current_exp = ExpManager.current_exp + 5
        ExpManager.bonus_bullet.emit()
        ExpManager.check_exp()
        queue_free()
