extends Node

var world

var first_tile : bool = false

var max_bombs : int = 20
var board_size: Vector2i = Vector2i(12, 10)

var PhantomClass = preload("res://PowerUps/Phantom.gd")
var phantom: Phantom = PhantomClass.new()

func _ready():
	#Start Phantom as deactive
	add_child(phantom)

func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")
