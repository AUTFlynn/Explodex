extends bait

func die():
	StateManager.add_points(-10)
	queue_free()

func kill():
	StateManager.add_points(10)
	queue_free()

func target_reached(target):
	if randf() < 0.25 and !target.dead:
		target.toggle_flag()
