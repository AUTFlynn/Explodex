extends Control

#@onready var restarted =$CanvasLayer/PanelContainer/MarginContainer/Display/CenterContainer/Buttons/Restart
@onready var restarted = $CanvasLayer/PanelContainer/MarginContainer/Display/CenterContainer/Buttons/Restart

func _ready():
	restarted.pressed.connect(_on_restart_pressed)

func _on_restart_pressed() -> void:
	#remove victory screen
	queue_free() 
	#reset tiles to prevent instant victory
	StateManager.first_tile = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
