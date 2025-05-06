extends Node2D
#objects
var t = preload("res://TileSystem/tile.tscn")

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
		i.sprite.visible = false #temporary visual change for development
		
		#loop through all 8 surrounding tiles (and the bomb)
		for x in range(i.pos.x-1, i.pos.x+2):
			for y in range(i.pos.y-1, i.pos.y+2):
				#use our dictionary to locate the tile object and increment adjacent_bombs
				if tiles.has(Vector2i(x,y)):
					tiles[Vector2i(x,y)].adjactent_bombs += 1
		


func _ready():
	StateManager.world = self
	create_grid()

