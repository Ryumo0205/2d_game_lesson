# 定義State類別
extends Node
class_name State

# 切換狀態時發射
signal state_transition


func enter():
	pass  # 當進入該狀態時執行的代碼

func exit():
	pass  # 當退出該狀態時執行的代碼

func update(_delta):
	pass  # 在每幀更新時執行的代碼
	
