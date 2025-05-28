extends Node

var world
var time : float = 0
var first_tile : bool = false

var max_bombs : int = 20
var board_size: Vector2i = Vector2i(12, 10)
var mode = "Medium"
var leaderboard

func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")

func _ready():
	get_leaderboard()

func get_leaderboard():
	var http = HTTPRequest.new()
	add_child(http)

	#connect the request completion to our function
	http.request_completed.connect(_on_leaderboard_received)

	#setup request params
	var url = "http://localhost:8000/leaderboard"
	var headers = ["Content-Type: application/json"]	
	var body = ""

	#send get request
	var err = http.request(url, headers, HTTPClient.METHOD_GET, body)
	if err != OK:
		print("Request failed to send:", err)
	
func _on_leaderboard_received(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Request failed, result code:", result)
		return
	leaderboard = body
	print("HTTP Response Code:", response_code)
	print("Body:", body.get_string_from_utf8())
