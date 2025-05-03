extends Node

# 排行榜最大紀錄數
const MAX_ENTRIES := 3
# 排行榜資料儲存路徑（如需跨平台建議用 user://）
const SAVE_FILE := "G://file//temp/save.json"
# 名次對應的鍵值陣列
const RANK_KEYS := ["1st", "2nd", "3rd"]

# 用來儲存排行榜分數的陣列
var entries : Array = []

# 新增一筆分數到排行榜
func add_entry(score: int) -> void:
    entries.append(score)                  # 新增分數
    entries.sort()                         # 先由小到大排序
    entries.reverse()                      # 再反轉為由大到小
    if entries.size() > MAX_ENTRIES:       # 若超過最大筆數，就只保留前三名
        entries.resize(MAX_ENTRIES)
    save_to_file()                         # 每次新增後自動存檔

# 取得排行榜資料（用字典回傳，例如 {"1st": 1000, "2nd": 500, "3rd": 300}）
func get_entries_dict() -> Dictionary:
    var dict := {}
    for i in range(MAX_ENTRIES):
        dict[RANK_KEYS[i]] = entries[i] if entries.size() > i else null # 未滿三筆則補 null
    return dict

## 取得排行榜資料（用固定長度陣列回傳，適合UI用）
#func get_entries_array() -> Array:
    #var result := []
    #for i in range(MAX_ENTRIES):
        #result.append(entries[i] if entries.size() > i else null)      # 不足則補 null
    #return result

# 從檔案讀取排行榜
func load_from_file() -> void:
    if not FileAccess.file_exists(SAVE_FILE): # 如果沒有檔案，清空資料
        entries = []
        return
    var file := FileAccess.open(SAVE_FILE, FileAccess.READ)
    if file:
        var text := file.get_as_text()
        var data = JSON.parse_string(text)
        entries = []
        if typeof(data) == TYPE_DICTIONARY:
            for key in RANK_KEYS:
                if data.has(key) and data[key] != null:
                    entries.append(int(data[key])) # 依照名次順序填入分數
        file.close()

# 將排行榜儲存到檔案
func save_to_file() -> void:
    var dict := {}
    for i in range(MAX_ENTRIES):
        dict[RANK_KEYS[i]] = entries[i] if entries.size() > i else null # 補 null
    var file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
    if file:
        var text := JSON.stringify(dict) # 轉成 JSON 字串
        file.store_string(text)          # 寫入檔案
        file.close()
