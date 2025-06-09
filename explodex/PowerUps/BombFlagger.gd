extends Node
class_name BombFlagger

var active: bool = false
var available: bool = true  # Available at game start
var uses: int = 1  # Number of times it can be used

func activate():
	if available and uses > 0:
		active = true
		uses -= 1
		flag_three_bombs()
		return true
	return false

func flag_three_bombs():
	var flagged_count = 0
	for tile in StateManager.world.mine_array:
		if flagged_count < 3 and !tile.flagged:
			tile.flagged = true
			tile.flag.visible = true
			flagged_count += 1

func reset():
	active = false
	available = true
	uses = 1
