extends Control


func _on_restart_pressed() -> void:
	#remove victory screen
	queue_free() 
	#reset tiles to prevent instant victory or gameover
	StateManager.first_tile = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
