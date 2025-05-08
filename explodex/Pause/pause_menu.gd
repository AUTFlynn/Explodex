class_name PauseMenu
extends Control



func _ready():
	get_tree().paused = true

func _on_continue_button_down() -> void:
	get_tree().paused = false
	queue_free()


func _on_restart_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_quit_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
 
