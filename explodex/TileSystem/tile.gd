extends Node2D

var over = preload("res://gameover.tscn")

const tile_size = 16
var board_size_x = 5
var board_size_y = 5
var offset = Vector2((board_size_x*tile_size)/2-tile_size/2, (board_size_y*tile_size)/2-tile_size/2)
static var cleared = 0

func _ready():
	cleared = 0

func _input(event):
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		var top_left = global_position - Vector2(tile_size/2,tile_size/2)
		var rect = Rect2(top_left, Vector2(tile_size, tile_size))
		if rect.has_point(get_global_mouse_position()):
			queue_free()
			cleared += 1
			if(cleared == (board_size_x * board_size_y)):
				var o = over.instantiate()
				get_parent().add_child(o)
