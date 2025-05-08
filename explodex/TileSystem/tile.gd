extends Node2D
class_name tile 

var sprite_size = 16
var pos : Vector2i
var bomb : bool = false
var adjactent_bombs : int = 0
var flagged : bool = false

@onready var sprite = $Sprite2D

##mouse events for the tile
func _input(event):
	$RichTextLabel.text = str(adjactent_bombs) #TEMPORARY 
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

func toggle_flag():
	#check to see if the tile is flagged and place one if not
		flagged = !flagged
		if flagged:
			#create a flag tile
			sprite.texture = preload("res://Sprites/DevSprites/flag.png")
			sprite.scale = Vector2(sprite_size / float(sprite.texture.get_width()), sprite_size / float(sprite.texture.get_height()))
		else:
			#reset the scaling and tile to default
			sprite.texture = preload("res://Sprites/DevSprites/square.png")
			sprite.scale = Vector2(1,1)
