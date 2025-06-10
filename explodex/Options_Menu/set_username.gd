extends Control

func _ready():
	$TextEdit.text = StateManager.username
func _on_text_edit_text_changed():
	StateManager.username = $TextEdit.text
