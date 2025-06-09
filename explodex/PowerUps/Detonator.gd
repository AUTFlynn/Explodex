extends Node
class_name Detonator

var active: bool = false  # Track if the detonator is in use
var available: bool = true  # Available at game start
var count: int = 1  # Only one charge

func activate():
	if available and count > 0:
		active = true
		count -= 1
		reveal_bomb()  # Automatically reveal a bomb when activated
		return true
	return false 

func reveal_bomb():
	if active and StateManager.world:
		# Find the first bomb tile in the game board
		for tile in StateManager.world.mine_array:
			if tile.bomb and !tile.flagged:
				tile.remove_tile()
				tile.cascadeRemove()
				
				# Deactivate detonator after revealing one bomb
				active = false
				available = false
				return  # Exit after revealing the first bomb

func reset():
	active = false  
	available = true
	count = 1
