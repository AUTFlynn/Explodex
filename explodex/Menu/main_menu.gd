class_name MainMenu
extends Control


@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button as Button
@onready var options_menu = $Options_Menu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

@onready var leaderboard_button = $MarginContainer/HBoxContainer/VBoxContainer/LeaderboardButton
@onready var leaderboard_menu = $LeaderboardMenu
@onready var start_level = preload("res://Scenes/world.tscn") as PackedScene

func _ready():
	handle_connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false

func on_exit_leaderboard_menu():
	margin_container.visible = true
	leaderboard_menu.visible = false
	
func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	leaderboard_menu.exit_leaderboard_menu.connect(on_exit_leaderboard_menu)


func _on_leaderboard_button_pressed():
	margin_container.visible = false
	#leaderboard_menu.set_process(true)
	leaderboard_menu.visible = true
