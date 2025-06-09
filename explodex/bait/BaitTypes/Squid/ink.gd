extends Node2D

var t
var was_text_visible

func _on_timer_timeout():
	t.text.visible = was_text_visible
	t.grace = false
	t.inked = false
	queue_free()

func _ready():
	t = get_parent()
	was_text_visible = t.text.visible
	t.text.visible = false
	t.grace = true
