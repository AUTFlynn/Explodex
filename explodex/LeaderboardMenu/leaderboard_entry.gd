extends Control

@onready var text = $RichTextLabel


func set_text(username, score):
	text.text = username + " : " + str(score)
