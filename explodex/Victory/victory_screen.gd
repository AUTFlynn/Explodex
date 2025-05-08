extends Control

func _on_restart_pressed() -> void:
	get_tree().change_scene("res://Scenes/world.gd")

func _on_quit_pressed() -> void:
	get_tree().quit()
