extends Node2D
class_name tile 

var sprite_size = 16
var pos : Vector2i
var bomb : bool = false
var dead : bool = false
var adjactent_bombs : int = 0

@onready var sprite = $Sprite2D
@onready var victory_scene = preload("res://Victory/victory_screen.tscn")
@onready var gameover_scene = preload("res://Gameover/gameover.tscn")

var flagged : bool = false

@onready var flag = $flag


##mouse events for the tile
func _input(event):
	if bomb: ##TEMP CHANGED FOR API TESTTING
		sprite.visible = false##TEMP CHANGED FOR API TESTTING
	update_adjacent_display()
	if event is InputEventMouseButton and event.pressed:
		var local_mouse_pos = get_local_mouse_position()
		if abs(local_mouse_pos.x) < sprite_size/2 and abs(local_mouse_pos.y) < sprite_size/2:
			if event.is_action("left_click"):
				#prevent clicking flagged tiles
				if not flagged:
					onClick(true)
			if event.is_action("right_click"):
				#use flag function to place or remove flag
				toggle_flag()

func onClick(left):
	if left:   
		##if this is the first tile being clicked remove a set around it
		if StateManager.first_tile == false:
			StateManager.time = 0
			StateManager.world.spawn_bombs(pos)
			StateManager.first_tile = true
		if bomb:
			SoundManager.play(0)
		cascadeRemove()
		remove_tile()

func cascadeRemove(visited := {}, stop = false):
	#add our current position to visited dictionary
	if visited.has(pos):
		return
	visited[pos] = true

	#loop through adjacent tiles (ignoring diagonals)
	var directions = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1),
	Vector2i(1,1),Vector2i(1,-1),Vector2i(-1,1),Vector2i(-1,-1)]
	for i in directions:
		var x = pos.x + i.x
		var y = pos.y + i.y
		if StateManager.world.tiles.has(Vector2i(x,y)):
			var t = StateManager.world.tiles[Vector2i(x,y)]
			if t.adjactent_bombs == 0:
				remove_tile()
				if !stop:
					t.cascadeRemove(visited)
			else:
				if !stop:
					t.cascadeRemove(visited, true)

func remove_tile():
	$Sprite2D2.visible = false
	dead = true
	check_victory()

#check victory conditions
func check_victory():
	#display game over
	if bomb:
		show_gameover()
	#display victory
	if StateManager.world.all_safe_tiles_cleared():
		show_victory()

#show gameover
func show_gameover():
	#remove current scene
	get_tree().current_scene.queue_free()
	var gameover = gameover_scene.instantiate()
	get_tree().root.add_child(gameover)

#show victory
func show_victory():
	#remove current scene
	get_tree().current_scene.queue_free()
	var victory = victory_scene.instantiate()
	get_tree().root.add_child(victory)



func toggle_flag():
	#check to see if the tile is flagged and place one if not
		flagged = !flagged
		if flagged:
			flag.visible = true
		else:
			flag.visible = false

func update_adjacent_display():
	var adjacent = 0
	var directions = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1),
	Vector2i(1,1),Vector2i(1,-1),Vector2i(-1,1),Vector2i(-1,-1)]
	for i in directions:
		var x = pos.x + i.x
		var y = pos.y + i.y
		if StateManager.world.tiles.has(Vector2i(x,y)):
			if StateManager.world.tiles[Vector2i(x,y)].dead == false:
				adjacent += 1
	if adjacent > 0 and dead:
		$RichTextLabel.visible = true
		$RichTextLabel.text = str(adjactent_bombs)
	else:
		$RichTextLabel.visible = false
