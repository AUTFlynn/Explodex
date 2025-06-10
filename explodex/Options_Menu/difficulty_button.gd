extends Control


@onready var option_button: OptionButton = $HBoxContainer/OptionButton as Button


const DIFFICULTY_MODE_ARRAY :Array[String] = [
	"Easy",
	"Medium",
	"Hard"
]

const DIFFICULTY_BOMB_COUNTS = {
	"Easy": 10,
	"Medium": 25,
	"Hard": 40
}

const DIFFICULTY_GRID_SIZES = {
	"Easy": Vector2i(8, 8),
	"Medium": Vector2i(14, 12),
	"Hard": Vector2i(21, 12)
}

func _ready():
	option_button.item_selected.connect(on_difficulty_selected)
	for difficulty in DIFFICULTY_MODE_ARRAY:
		option_button.add_item(difficulty)

func on_difficulty_selected(index):
	var difficulty = DIFFICULTY_MODE_ARRAY[index]
	StateManager.board_size = DIFFICULTY_GRID_SIZES[difficulty]
	StateManager.max_bombs = DIFFICULTY_BOMB_COUNTS[difficulty]
	StateManager.mode = difficulty
	
