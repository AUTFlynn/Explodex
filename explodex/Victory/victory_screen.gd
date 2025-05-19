extends Control



func _on_restart_button_down() -> void:
	#remove victory screen
	queue_free() 
	#reset tiles to prevent instant victory or gameover
	StateManager.first_tile = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_button_down() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _ready():
	$CanvasLayer/PanelContainer/MarginContainer/Display/score_text.text = str(StateManager.time) + " Seconds"

func _on_http_request_request_completed(result, response_code, headers, body):
	pass # Replace with function body.
