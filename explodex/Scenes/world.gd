extends Node2D
#objects
var t = preload("res://TileSystem/tile.tscn")

#settings
const tile_size = 16
var board_size_x = 8
var board_size_y = 8

enum Difficulty { EASY, MEDIUM, HARD }

#difficulty settings
func set_difficulty(difficulty: int):
	match difficulty:
		Difficulty.EASY:
			board_size_x = 8
			board_size_y = 8
		Difficulty.MEDIUM:
			board_size_x = 14
			board_size_y = 14
		Difficulty.HARD:
			board_size_x = 20
			board_size_y = 16

#sets up initial tile grid
func create_grid():
	for child in get_children():
		if child.name.begins_with("Tile"):
			child.queue_free()
	
	for i in range(0, board_size_x):
		for j in range(0, board_size_y):
			var ti = t.instantiate()
			add_child(ti)
			ti.name = "Tile_%d_%d" % [i, j]
			var offset = Vector2((board_size_x*tile_size)/2-tile_size/2, (board_size_y*tile_size)/2-tile_size/2)
			ti.position = Vector2(i*tile_size,j*tile_size) - offset

			
	
func _on_easy_button_pressed() -> void:
	set_difficulty(Difficulty.EASY)
	create_grid()
	$CanvasLayer.hide()

func _on_medium_button_pressed() -> void:
	set_difficulty(Difficulty.MEDIUM)
	create_grid()
	$CanvasLayer.hide()

func _on_hard_button_pressed() -> void:
	set_difficulty(Difficulty.HARD)
	create_grid()
	$CanvasLayer.hide()
