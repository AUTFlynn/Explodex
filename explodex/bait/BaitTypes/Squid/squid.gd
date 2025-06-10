extends bait

var ink = preload("res://bait/BaitTypes/Squid/ink.tscn")

func die():
	StateManager.score -= 10
	queue_free()

func kill():
	StateManager.score += 10
	queue_free()

func target_reached(target):
	if !target.inked and !(target.dead and !target.visible):
		target.inked = true
		var i = ink.instantiate()
		target.add_child(i)
		i.position = Vector2.ZERO
