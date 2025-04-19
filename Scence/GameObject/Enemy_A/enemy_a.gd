extends CharacterBody2D  # 假設你的敵人是 CharacterBody2D 節點

@export var speed: float = 50.0  # 調整敵人移動速度
@export var max_hp : int = 10
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
    hit_box.area_entered.connect(on_hit)
    animation_player.animation_finished.connect(on_ani_finished)
    

func _process(delta: float) -> void:
    pass
    #var player: Node2D = get_tree().current_scene.get_node("Player")  # 確保路徑正確
    #var direction = Vector2.ZERO
    #
    #if player == null :
        #return
        #
    #if is_hit == true :
        #if look_right == true:
            #animation_player.play("hit_right")
            #return
        #if look_left == true:
            #animation_player.play("hit_left")
            #return
    #
    #
    ## 計算方向向量（從敵人到玩家）
    #direction = (player.global_position - global_position).normalized()
    #which_side(direction)
    ## 使用 CharacterBody2D 的 move_and_slide() 方法移動敵人
    #if look_right == true:
        #animation_player.play("run_right")
    #if look_left == true:
        #animation_player.play("run_left")
    #
    #velocity = direction * speed
    #move_and_slide()


func which_side(direction):
    if direction.x > 0 :
        look_right = true
        look_left = false
    
    if direction.x < 0 :
        look_right = false
        look_left = true

func on_hit(area):
    is_hit = true
    current_hp = current_hp - 1
    SfxManager.play_hit_sfx()
    check_hp()
    
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
        ExpManager.check_exp()
        queue_free()
