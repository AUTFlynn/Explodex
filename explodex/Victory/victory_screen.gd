extends Control

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
