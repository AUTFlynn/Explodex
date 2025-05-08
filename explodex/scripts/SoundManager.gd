extends Node

#an array of all our sound effects, let me know if you need more sound can add!
var sounds = [load("res://sounds/ESM_PG_cinematic_fx_weapons_warefare_cannon_shot_ship_clanking_metal_02.wav")]

func play(sound_id):
	#instantite an audio player and load our sound based of an id
	var sound = AudioStreamPlayer.new()
	get_tree().root.add_child(sound)
	sound.stream = sounds[sound_id]
	sound.play()
	
	#wait 5 seconds then delete the player
	await get_tree().create_timer(10.0).timeout 
	sound.queue_free()
	
	
