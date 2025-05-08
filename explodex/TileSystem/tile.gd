extends Node2D
class_name tile 

var sprite_size = 16
var pos : Vector2i
var bomb : bool = false
var adjactent_bombs : int = 0

@onready var sprite = $Sprite2D
@onready var victory_scene = preload("res://Victory/victory_screen.tscn")
@onready var gameover_scene = preload("res://Gameover/gameover.tscn")

##mouse events for the tile
func _input(event):
	$RichTextLabel.text = str(adjactent_bombs) #TEMPORARY 
	if event is InputEventMouseButton and event.pressed:
		var local_mouse_pos = get_local_mouse_position()
		if abs(local_mouse_pos.x) < sprite_size/2 and abs(local_mouse_pos.y) < sprite_size/2:
			if event.is_action("left_click"):
				onClick(true)
			if event.is_action("right_click"):
				onClick(false)

func onClick(left):
	if left:
		##if this is the first tile being clicked remove a set around it
		if StateManager.first_tile == false:
			StateManager.world.spawn_bombs(pos)
			StateManager.first_tile = true
			cascadeRemove()
		
		##logic to remove tile (queue_free())
		if bomb:
			SoundManager.play(0)
		cascadeRemove()
		remove_tile()
	else:
		pass #right click on tiles

func cascadeRemove(last : tile = null, visited := {}):
	#remove our previous tile
	if last:
		remove_tile()
	#add our current position to visited dictionary
	if visited.has(pos):
		return
	visited[pos] = true

	
	#loop through adjacent tiles (ignoring diagonals)
	var directions = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
	for i in directions:
		var x = pos.x + i.x
		var y = pos.y + i.y
		if StateManager.world.tiles.has(Vector2i(x,y)):
			#if our tile has 0 adjacent bombs, continue the recurssion
			var t = StateManager.world.tiles[Vector2i(x,y)]
			if t.adjactent_bombs == 0:
				t.cascadeRemove(t, visited)
				remove_tile()

func remove_tile():
	#delete tile and remove from the dict
	StateManager.world.tiles.erase(pos)
	queue_free()
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
