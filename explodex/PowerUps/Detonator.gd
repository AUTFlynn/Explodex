extends Node
class_name Detonator

#Track if the detonator is in use
var active: bool = false  
#Available at game start
var available: bool = true  
#Only one charge
var count: int = 1  

func activate():
	if available and count > 0:
		active = true
		count -= 1
		#Automatically reveal a bomb when activated
		reveal_bomb()  
		return true
	return false 

var bomb_sound = preload("res://sounds/bomb-countdown-beeps-6868.mp3")

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
				# Exit after revealing the first bomb
				return  

func play_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = bomb_sound
	sound_player.play()
	#Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()

func reset():
	active = false  
	available = true
	count = 1
