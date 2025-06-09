extends Control

var entry = preload("res://LeaderboardMenu/LeaderboardEntry.tscn")
@onready var timer = $Timer
@onready var container = $MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit_Button as Button


signal exit_leaderboard_menu

func _ready():
	exit_button.button_down.connect(on_exit_pressed)


func _on_timer_timeout():
	insert_leaderboard()

func insert_leaderboard():
	#keep trying to get leaderboard until it has loaded from API
	var easy = StateManager.easy
	var medium = StateManager.medium
	var hard = StateManager.hard
	var special = StateManager.special
	if !easy or !medium or !hard or !special:
		timer.start(1.0)
		return
	
	#easy 	
	for i in range(0, easy.size()):
		var e = entry.instantiate()
		$MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer/Easy.add_child(e)
		e.call_deferred("set_text", easy[i][0], easy[i][1])
	
	#medium
	for i in range(0, medium.size()):
		var e = entry.instantiate()
		$MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer/Medium.add_child(e)
		e.call_deferred("set_text", medium[i][0], medium[i][1])

	for i in range(0, hard.size()):
		var e = entry.instantiate()
		$MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer/Hard.add_child(e)
		e.call_deferred("set_text", hard[i][0], hard[i][1])
	
	for i in range(0, special.size()):
		var e = entry.instantiate()
		$MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer/Special.add_child(e)
		e.call_deferred("set_text", special[i][0], special[i][1])	

func on_exit_pressed() -> void:
	exit_leaderboard_menu.emit()
