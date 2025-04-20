extends Node

# OpenAI API密鑰
var api_key = "Your API Key"
# API端點URL
var url = "https://api.openai.com/v1/chat/completions"

func _ready():
	# 發送一個測試請求
	send_openai_request("扮演一個rpg遊戲的商店npc老闆與我對話, 給我一個簡短的回覆, 你只要說老闆的台詞, 不要說玩家的")

func send_openai_request(prompt: String):
	# 創建HTTP請求
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	
	# 設置請求頭
	var headers = [
		"Content-Type: application/json",
		"Authorization: Bearer " + api_key
	]
	
	# 準備要發送的數據
	var data = {
		"model": "gpt-3.5-turbo",
		"messages": [
			{
				"role": "user",
				"content": prompt
			}
		],
		"temperature": 0.7
	}
	
	# 將數據轉換為JSON
	var json_data = JSON.stringify(data)
	
	# 發送請求
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	if error != OK:
		print("發送請求時出現錯誤:", error)

# 請求完成時的回調函數
func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("請求失敗，錯誤碼:", result)
		return
	
	# 處理返回的數據
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	if parse_result == OK:
		var response = json.get_data()
		if response.has("choices") and response["choices"].size() > 0:
			var message = response["choices"][0]["message"]["content"]
			print(message)
	else:
		print("解析JSON時出現錯誤")
