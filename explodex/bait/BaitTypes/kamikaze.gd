extends bait

func target_reached(target):
	target.remove_tile()
	target.update_adjacent_display()
