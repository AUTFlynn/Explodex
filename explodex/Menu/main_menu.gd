class_name MainMenu
extends Control


@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button as Button
@onready var background_display = $BackgroundDisplay
@onready var theme_music: AudioStreamPlayer = $MusicStreamPlayer
@onready var options_menu: OptionsMenu = $Options_Menu as OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer



@onready var start_level = preload("res://Scenes/world.tscn") as PackedScene

var music_tracks = [
	preload("res://music/theme_1.mp3"),
	preload("res://music/theme_2.mp3"),
	preload("res://music/theme_3.mp3")
]

var background_paths = [
	preload("res://Background/Background_001.png"),  # Normal
	preload("res://Background/Background_002.png"),  # Science
	preload("res://Background/Background_003.png")   # Space
]

func _ready():
	handle_connecting_signals()
	apply_theme_background()
	play_theme_music()

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
	
func _on_theme_changed(index: int) -> void:
	apply_theme_background()

func handle_connecting_signals() -> void:
	options_menu.theme_music_changed.connect(_on_theme_music_changed)
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	options_menu.background_theme_changed.connect(_on_theme_changed)

func apply_theme_background():
	var index := 0
	if FileAccess.file_exists("user://theme.cfg"):
		var file = FileAccess.open("user://theme.cfg", FileAccess.READ)
		index = int(file.get_line())
		file.close()
	background_display.texture = background_paths[index]
	
func play_theme_music():
	var index := 0
	if FileAccess.file_exists("user://theme.cfg"):
		var file = FileAccess.open("user://theme.cfg", FileAccess.READ)
		index = int(file.get_line())
		file.close()
	theme_music.stream = music_tracks[index]
	theme_music.play()
	
func _on_theme_music_changed(index: int):
	theme_music.stop()
	theme_music.stream = music_tracks[index]
	theme_music.play()
