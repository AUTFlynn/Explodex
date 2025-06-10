extends Node
class_name BombFlagger

var active: bool = false
#Available at game start
var available: bool = true  
#Number of times it can be used
var uses: int = 1  

var bombflagger_sound = preload("res://sounds/impact-whoosh-drum-314548.mp3")

func activate():
	if available and uses > 0:
		active = true
		uses -= 1
		play_sound()
		flag_three_bombs()
		return true
	return false

func flag_three_bombs():
	var flagged_count = 0
	for tile in StateManager.world.mine_array:
		if flagged_count < 3 and tile.bomb and !tile.flagged:
			tile.flagged = true
			tile.flag.visible = true
			flagged_count += 1

func play_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = bombflagger_sound
	sound_player.play()
	#Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()

func reset():
	active = false
	available = true
	uses = 1
