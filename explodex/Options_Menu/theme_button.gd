extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton as OptionButton

const THEME_MODE_ARRAY :Array[String] = [
	"Normal",
	"Science",
	"Space"
]


func _ready():
	for theme in THEME_MODE_ARRAY:
		option_button.add_item(theme)

	option_button.connect("item_selected", Callable(self, "_on_theme_selected"))
	load_theme_choice()

func load_theme_choice():
	if FileAccess.file_exists("user://theme.cfg"):
		var file = FileAccess.open("user://theme.cfg", FileAccess.READ)
		var index = int(file.get_line())
		file.close()
		option_button.select(index)

func _on_theme_selected(index: int):
	save_theme_choice(index)

func save_theme_choice(index: int):
	var file = FileAccess.open("user://theme.cfg", FileAccess.WRITE)
	file.store_line(str(index))
	file.close()
