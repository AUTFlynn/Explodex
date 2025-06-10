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
	update_phantom_display()
	update_flagger_display()
	update_infrared_display()
	update_detonator_display()
	update_gamble_display()


func resetLevel():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")
	

func _on_phantom_pressed() -> void:
	StateManager.phantom.activate()
	update_phantom_display()


func _on_bomb_flagger_pressed() -> void:
	StateManager.bombflagger.activate()
	update_flagger_display()


func _on_infrared_pressed() -> void:
	StateManager.infrared.activate()
	update_infrared_display()

func _on_detonator_pressed() -> void:
	StateManager.detonator.activate()
	update_detonator_display()

func _on_gamble_pressed() -> void:
	StateManager.gamble.activate()
	update_gamble_display()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	StateManager.phantom.reset()
	StateManager.bombflagger.reset()
	StateManager.infrared.reset()
	StateManager.detonator.reset()
	StateManager.gamble.reset()

func _on_shop_button_pressed() -> void:
	pass # Replace with function body.

@onready var phantom_ui = $PowerUps/Phantom0  # Adjust path to match your UI

var phantom_textures = [
	preload("res://Sprites/DevSprites/Phantom0.png"),  # When uses = 0
	preload("res://Sprites/DevSprites/Phantom1.png"),
	preload("res://Sprites/DevSprites/Phantom2.png"),
	preload("res://Sprites/DevSprites/Phantom3.png"),
	preload("res://Sprites/DevSprites/Phantom4.png")   # When uses = 5 (max)
]
func update_phantom_display():
	var count_level = clamp(StateManager.phantom.count, 0, 5)  # Ensure valid range
	phantom_ui.texture = phantom_textures[count_level]  # Set correct texture

@onready var flagger_ui = $PowerUps/BombFlagger0  # Adjust path to match your UI
var bombflagger_textures = [
	preload("res://Sprites/DevSprites/Flagger0.png"),  # When uses = 0
	preload("res://Sprites/DevSprites/Flagger1.png"),
	preload("res://Sprites/DevSprites/Flagger2.png"),
	preload("res://Sprites/DevSprites/Flagger3.png"),
	preload("res://Sprites/DevSprites/Flagger4.png")   # When uses = 5 (max)
]
func update_flagger_display():
	var uses_level = clamp(StateManager.bombflagger.uses, 0, 5)  # Ensure valid range
	flagger_ui.texture = bombflagger_textures[uses_level]  # Set correct texture

@onready var infrared_ui = $PowerUps/Infrared0  # Adjust path to match your UI
var infrared_textures = [
	preload("res://Sprites/DevSprites/Infrared0.png"),  # When uses = 0
	preload("res://Sprites/DevSprites/Infrared1.png"),
	preload("res://Sprites/DevSprites/Infrared2.png"),
	preload("res://Sprites/DevSprites/Infrared3.png"),
	preload("res://Sprites/DevSprites/Infrared4.png")   # When uses = 5 (max)
]
func update_infrared_display():
	var charge_level = clamp(StateManager.infrared.charge, 0, 5)  # Ensure valid range
	infrared_ui.texture = infrared_textures[charge_level]  # Set correct texture

@onready var detonator_ui = $PowerUps/Detonator0  # Adjust path to match your UI
var detonator_textures = [
	preload("res://Sprites/DevSprites/Detonator0.png"),  # When uses = 0
	preload("res://Sprites/DevSprites/Detonator1.png"),
	preload("res://Sprites/DevSprites/Detonator2.png"),
	preload("res://Sprites/DevSprites/Detonator3.png"),
	preload("res://Sprites/DevSprites/Detonator4.png")   # When uses = 5 (max)
]
func update_detonator_display():
	var count_level = clamp(StateManager.detonator.count, 0, 5)  # Ensure valid range
	detonator_ui.texture = detonator_textures[count_level]  # Set correct texture

@onready var gamble_ui = $PowerUps/Gamble0  # Adjust path to match your UI
var gamble_textures = [
	preload("res://Sprites/DevSprites/Gamble0.png"),  # When uses = 0
	preload("res://Sprites/DevSprites/Gamble1.png"),
	preload("res://Sprites/DevSprites/Gamble2.png"),
	preload("res://Sprites/DevSprites/Gamble3.png"),
	preload("res://Sprites/DevSprites/Gamble4.png")   # When uses = 5 (max)
]
func update_gamble_display():
	var charge_level = clamp(StateManager.gamble.charge, 0, 5)  # Ensure valid range
	gamble_ui.texture = gamble_textures[charge_level]  # Set correct texture
