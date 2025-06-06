extends bait

func die():
	print("DEAD")
	queue_free()
	
func target_reached(target):
	print(target)
