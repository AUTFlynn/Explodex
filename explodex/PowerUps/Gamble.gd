extends Node
class_name Gamble

var active: bool = false  
var charge: int = 1  
var chosen_powerup: String = ""  # Store selected power-up
var powerups = ["detonator", "phantom", "infrared", "bombflagger"]
#var gamble_sound = preload()  # Replace with actual sound file

func activate():
	if active or charge <= 0:
		return
	active = true
	charge -= 1
	play_sound()
	choose_random_powerup()
	await get_tree().create_timer(3.0).timeout  # Simulated effect duration
	deactivate()

func deactivate():
	if not active:
		return
	active = false

func choose_random_powerup():
	chosen_powerup = powerups[randi() % powerups.size()]  # Random selection

	match chosen_powerup:
		"detonator":
			StateManager.detonator.count += 1
			StateManager.detonator.activate()
		"phantom":
			StateManager.phantom.count += 1
			StateManager.phantom.activate()
		"infrared":
			StateManager.infrared.charge += 1
			StateManager.infrared.activate()
		"bombflagger":
			StateManager.bombflagger.uses += 1
			StateManager.bombflagger.activate()

	print("Gamble activated:", chosen_powerup)

func play_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	#sound_player.stream = gamble_sound
	sound_player.play()

	# Ensure sound player is removed after playback
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()

func reset():
	active = false  
	charge = 1  
	chosen_powerup = ""  # Reset selected power-up
