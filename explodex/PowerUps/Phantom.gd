extends Node
class_name Phantom


#Not active until player uses it
var active: bool = false 
#Available on game start
var available: bool = true  
#Starting amount, reset on restart
var count: int = 1  

func activate():
	if available and count > 0:
		active = true
		count -= 1
		return true
	return false 

func click():
	if active:
		# Prevent death, deactivate powerup
		active = false
		return true
	return false

func reset():
	active = false  
	available = true
	count = 1
