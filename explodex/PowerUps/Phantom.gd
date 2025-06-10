extends Node
class_name Phantom

var phantom_sound = preload("res://sounds/classic-ghost-sound-95773.mp3")

#Not active until player uses it
var active: bool = false 
#Available on game start
var available: bool = true  
#Starting amount, reset on restart
var count: int = 4 

func activate():
	if available and count > 0:
		active = true
		count -= 1
		return true
	return false 

func click():
	if active:
		# Prevent death, deactivate powerup
		active = false
		return true
	return false

func reset():
	active = false  
	available = true
	count = 4

func play_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = phantom_sound
	sound_player.play()

	# Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()
	
