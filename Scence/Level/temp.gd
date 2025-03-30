extends Node

var score = 0
var score_b : float = 0.0
var my_name : String = "123"
var temp_a : bool = false
var list_a = [score, score_b, my_name, temp_a]
var list_b = ["A", "B", "C", "D"]
var dict = {"hp": 100, "name": "Player", "sp": 50.2 }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	
	for i in list_b:
		if i == "C":
			print("Yes")
			break
		else:
			print("No")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
