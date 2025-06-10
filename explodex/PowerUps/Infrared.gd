extends Node
class_name Infrared

var active: bool = false
var charge: int = 1
#Duration bomb textures are changed
var highlight_duration: float = 3.0  
#Number of bombs to reveal
var highlight_count: int = 5  
#Stores highlighted bombs
var highlighted_tiles = []  
var revealbomb_texture = preload("res://Sprites/DevSprites/Reveal.png")  # New texture for revealed bombs
var infrared_sound = preload("res://sounds/night-vision-100467.mp3")

func activate():
	if active or charge <=0:
		return
	active = true
	charge -= 1
	play_sound()
	change_bomb_textures()
	await get_tree().create_timer(highlight_duration).timeout
	deactivate()

func deactivate():
	if not active:
		return
	active = false
	reset_bomb_textures()

func change_bomb_textures():
	highlighted_tiles.clear()
	#Select random bomb tiles
	var bomb_tiles = StateManager.world.mine_array.filter(func(tile): return tile.bomb and !tile.flagged)
	bomb_tiles.shuffle()
	highlighted_tiles = bomb_tiles.slice(0, highlight_count)
	#Show bomb icons
	for tile in highlighted_tiles:
		#Get bomb sprite
		var sprite = tile.get_node("Sprite2D")  
		#Store original state
		sprite.set_meta("original_texture", sprite.texture)  
		#Make bomb visible
		sprite.texture = revealbomb_texture  

func play_sound():
	var sound_player = AudioStreamPlayer.new()
	get_tree().root.add_child(sound_player)
	sound_player.stream = infrared_sound
	sound_player.play()
	#Ensure sound player is removed after it plays
	await get_tree().create_timer(5.0).timeout 
	sound_player.queue_free()

func reset_bomb_textures():
	for tile in highlighted_tiles:
		var sprite = tile.get_node("Sprite2D")
		#Restore original texture
		sprite.texture = sprite.get_meta("original_texture")  

func reset():
	active = false  
	charge = 1
