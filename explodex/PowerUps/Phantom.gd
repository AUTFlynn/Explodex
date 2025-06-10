extends Node
class_name Phantom

#change cursor when using phantom
var default_cursor = preload("res://Sprites/DevSprites/01.png")
var phantom_cursor = preload("res://Sprites/DevSprites/16.png")
var phantom_sound = preload("res://sounds/classic-ghost-sound-95773.mp3")
var phantom_die_sound = preload("res://sounds/ghost-whispers-6030.mp3")

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
		Input.set_custom_mouse_cursor(phantom_cursor)
		return true
	return false 

func click():
	if active:
		#Prevent death, deactivate powerup
		active = false
		Input.set_custom_mouse_cursor(default_cursor)
		return true
	return false

func reset():
	active = false  
	available = true
	count = 4
	Input.set_custom_mouse_cursor(default_cursor)

func play_phantom_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = phantom_sound
	sound_player.play()
	#Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()
	
func play_phantom_die_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = phantom_die_sound
	sound_player.play()
	#Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()
