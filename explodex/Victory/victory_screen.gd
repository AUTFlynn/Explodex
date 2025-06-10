extends Control

@onready var background_display: TextureRect = $CanvasLayer/TextureRect

var background_paths = [
	preload("res://Background/Background_004.png"),  # Theme 1
	preload("res://Background/Background_005.png"),  # Theme 2
	preload("res://Background/Background_006.png")   # Theme 3
]

func _on_restart_button_down() -> void:
	#remove victory screen
	queue_free() 
	#reset tiles to prevent instant victory or gameover
	StateManager.first_tile = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	StateManager.phantom.reset()
	StateManager.bombflagger.reset()
	StateManager.infrared.reset()
	StateManager.detonator.reset()
	StateManager.gamble.reset()

func _on_quit_button_down() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _ready():

	$CanvasLayer/PanelContainer/MarginContainer/Display/score_text.text = str(StateManager.time) + " Seconds"

	apply_theme_background()
	
func apply_theme_background():
	var index := 0
	if FileAccess.file_exists("user://theme.cfg"):
		var file = FileAccess.open("user://theme.cfg", FileAccess.READ)
		index = int(file.get_line())
		file.close()
	
	background_display.texture = background_paths[index]
