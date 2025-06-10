extends Control

@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit_Button as Button
@onready var option_button: OptionButton = $MarginContainer/VBoxContainer/Settings_Tab_Container/TabContainer/Theme/MarginContainer/ScrollContainer/VBoxContainer/Theme_Button/HBoxContainer/OptionButton as Button

signal exit_options_menu
signal background_theme_changed
signal theme_music_changed

func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	option_button.connect("item_selected", Callable(self, "_on_theme_selected"))


func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)


func _on_theme_selected(index: int):
	save_theme_choice(index)
	emit_signal("background_theme_changed", index)
	emit_signal("theme_music_changed", index)

func save_theme_choice(index: int):
	var file = FileAccess.open("user://theme.cfg", FileAccess.WRITE)
	file.store_line(str(index))
	file.close()
