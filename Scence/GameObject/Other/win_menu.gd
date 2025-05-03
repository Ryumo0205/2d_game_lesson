extends CanvasLayer

@onready var score_1_label = $"MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1st_score"
@onready var score_2_label = $"MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/2nd_score"
@onready var score_3_label = $"MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/3rd_score"

func _ready() -> void:

    var entries = RankManager.get_entries_dict()
    var keys = ["1st", "2nd", "3rd"]
    var labels = [score_1_label, score_2_label, score_3_label]
    
    for i in range(keys.size()):
        var score = entries.get(keys[i], null)
        labels[i].text = str(score) if score != null else "-"
