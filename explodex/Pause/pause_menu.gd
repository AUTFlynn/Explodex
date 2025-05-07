class_name PauseMenu
extends Control



func _on_continue_button_down() -> void:
	queue_free()


func _on_restart_button_down() -> void:
	pass # Replace with function body.


func _on_quit_button_down() -> void:
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
 
