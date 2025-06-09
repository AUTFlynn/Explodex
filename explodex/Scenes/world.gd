class_name MainGame
extends Node2D
#objects
var t = preload("res://TileSystem/tile.tscn")


#pause function
@export var pause_menu_packed_scene : PackedScene = null
@onready var ui_container: CanvasLayer = $UI_Container as CanvasLayer

func _unhandled_key_input(event) -> void:
	if event.is_action("pause"):
		var new_pause_menu : PauseMenu = pause_menu_packed_scene.instantiate()
		
		ui_container.add_child(new_pause_menu)


#settings
const tile_size = 16	
var board_size_x
var board_size_y
var tiles = {} #tile dictionary
var mine_array = []

#sets up initial tile grid
func create_grid():
	board_size_x = StateManager.board_size.x
	board_size_y = StateManager.board_size.y
	for i in range(0, board_size_x):
		for j in range(0, board_size_y):
			##instantiate the tile
			var ti = t.instantiate()
			add_child(ti)
			var offset = Vector2((board_size_x*tile_size)/2-tile_size/2, (board_size_y*tile_size)/2-tile_size/2)
			ti.position = Vector2(i*tile_size,j*tile_size) - offset #game world position
			ti.pos = Vector2i(i,j) #board position
			#add the tile to a dictianary, indexed by a vec2 e.g. first tile would be gotten by tiles.get(Vector2(0,0))
			tiles.set(Vector2i(i,j), ti)
			mine_array.append(ti)

##take our array of all tiles and select a handfull to be a bomb
func spawn_bombs(pos : Vector2i):
	##shuffle an array of all tiles to randomly select bombs
	mine_array.erase(tiles[pos])
	mine_array.shuffle()
	mine_array = mine_array.slice(0,StateManager.max_bombs) #this now becomes our mine array
	##loop through each mine
	for i in mine_array:
		i.bomb = true
		#loop through all 8 surrounding tiles (and the bomb)
		for x in range(i.pos.x-1, i.pos.x+2):
			for y in range(i.pos.y-1, i.pos.y+2):
				#use our dictionary to locate the tile object and increment adjacent_bombs
				if tiles.has(Vector2i(x,y)):
					tiles[Vector2i(x,y)].adjactent_bombs += 1

#check to see all safe tiles cleared
func all_safe_tiles_cleared():
	for t in tiles:
		if !tiles[t].bomb and !tiles[t].dead:
			return false
	return true

func _ready():
	get_tree().paused = false  # unpause in case it's a restart
	StateManager.world = self
	tiles.clear()
	StateManager.first_tile = false  # reset first-tile logic
	create_grid()
	


func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")
	

func _on_button_pressed() -> void:
	StateManager.phantom.activate()


func _on_bomb_flagger_pressed() -> void:
	StateManager.bombflagger.activate()


func _on_infrared_pressed() -> void:
	StateManager.infrared.activate()


func _on_detonator_pressed() -> void:
	StateManager.detonator.activate()
