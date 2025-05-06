extends Node2D

const tile_size = 16
var board_size_x = 12
var board_size_y = 10
var offset = Vector2((board_size_x*tile_size)/2-tile_size/2, (board_size_y*tile_size)/2-tile_size/2)

func _input(event):
	if (event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT):
		var top_left = global_position - Vector2(tile_size/2,tile_size/2)
		var rect = Rect2(top_left, Vector2(tile_size, tile_size))
		if rect.has_point(get_global_mouse_position()):
			queue_free()
