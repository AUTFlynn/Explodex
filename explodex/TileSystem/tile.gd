extends Node2D
class_name tile 

var sprite_size = 16
var revealed = false
var flagged = false


##mouse events for the tile
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var local_mouse_pos = get_local_mouse_position()
		if abs(local_mouse_pos.x) < sprite_size and abs(local_mouse_pos.y) < sprite_size:
			if event.is_action("left_click"):
				if not revealed and not flagged:
					reveal()
				
			if event.is_action("right_click"):
				if not revealed:
					toggle_flag()
				
func reveal():
	revealed = true
func toggle_flag():
	flagged = !flagged
