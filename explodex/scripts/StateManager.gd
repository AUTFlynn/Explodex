extends Node

var world

var first_tile : bool = false

var max_bombs : int = 20
var board_size: Vector2i = Vector2i(12, 10)

#Not active until player uses it
var phantom_active: bool = false 
#Available on game start
var phantom_available: bool = true  
#Starting amount, reset on restart
var phantom_count: int = 1  

func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")

func _ready():
	#Start Phantom as deactive
	phantom_active = false  
	phantom_available = true
	phantom_count = 1
