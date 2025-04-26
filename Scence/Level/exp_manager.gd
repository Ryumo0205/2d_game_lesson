extends Node

# ----- 自訂訊號區 -----
signal exp_update                    # 當經驗值有變動時發出
signal level_up(level:int)           # 等級提升時拋出訊號（包含新等級資訊）
signal bonus_bullet                  # 其他獎勵訊號（視遊戲自訂）

# ----- 主要屬性 -----
var current_lv := 1                  # 目前等級
var current_exp := 0                 # 當前經驗值
var max_exp := 10                    # 升級所需經驗值
var times := 1.5                    # 每次升級 max_exp 的成長倍率

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    pass


# 檢查是否升級
func check_exp() -> void:
    exp_update.emit()                      # 拋出經驗更新訊號給 UI 或其他系統
    # 若累積經驗已超過最大值就升級
    while current_exp >= max_exp:
        current_exp -= max_exp             # 扣掉本級已用經驗，保留超過的部分
        current_lv += 1                    # 等級+1
        level_up.emit(current_lv)          # 發送等級提升訊號
        max_exp = int(max_exp * times)     # 下級所需經驗值提升
        print(max_exp)
        # 根據遊戲設計可再這裡觸發 bonus_bullet 或其他升級效果
