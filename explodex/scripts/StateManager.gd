extends Node

var world
var time : float = 0
var first_tile : bool = false

var max_bombs : int = 20
var board_size: Vector2i = Vector2i(12, 10)
var mode = "Medium"

func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")

func _ready():
	get_leaderboard()
		
func get_leaderboard():
	var http = HTTPRequest.new()
	get_tree().root.add_child(http)
	print(http)
	var a = http.request("http://localhost:8000/leaderboard")
	print(a)
	
