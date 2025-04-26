extends Node
class_name FSM

# 當前的狀態
var current_state : State
# 儲存所有狀態的字典，鍵為狀態名稱(小寫)，值為狀態節點
var states_dict : Dictionary = {}
# 可在編輯器中設置的初始狀態
@export var initial_state : State

# 節點準備完成時執行
func _ready() -> void:
    # 遍歷所有子節點
    for child in get_children():
        # 如果子節點是 State 類型
        if child is State:

            # 將狀態添加到字典中，使用小寫名稱作為鍵
            states_dict[child.name.to_lower()] = child
            # 連接子節點的狀態轉換信號到 change_state 方法
            child.state_transition.connect(change_state)
            

    # 如果設置了初始狀態
    if initial_state != null:
        # 進入初始狀態
        initial_state.enter()
        # 將當前狀態設置為初始狀態
        current_state = initial_state

# 每一幀更新時執行
func _process(_delta: float) -> void:
    # 如果存在當前狀態，則調用其 update 方法
    if current_state:
        current_state.update(_delta)
    
# 物理更新時執行
func _physics_process(_delta: float) -> void:
    pass
    
# 狀態轉換方法
func change_state(old_state: State, new_state_name: String):
    
    # 檢查要離開的狀態是否為當前狀態，避免非法轉換
    if old_state != current_state:
        return
    
    # 從字典中獲取新狀態
    var new_state = states_dict.get(new_state_name.to_lower())
    # 如果新狀態不存在，輸出錯誤
    if new_state == null:
        printerr("new_state is empty.")
    
    # 如果當前有狀態，則調用其退出方法
    if current_state:
        current_state.exit()
    
    # 進入新狀態
    new_state.enter()
    # 更新當前狀態為新狀態
    current_state = new_state
    #print("current state : ", current_state)
    
    
