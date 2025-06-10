extends Node2D

#when creating a bait create a new node of type "bait" and add to bait_scenes
#You also have to add an entry to the weights array, and input the "weight" val
#the weight value effects probabilty of the bait spawning, it can be any number
#the spawn chance is relative to all other weights
@export var bait_scenes : Array[PackedScene]
@export var bait_weights : Array[float]
var weight_total : float

@onready var timer = $Timer

var min_spawn_time = 10
var max_spawn_time = 20
const spawn_positions = [Vector2(-250, 0), Vector2(250, 0), Vector2(0, -250), Vector2(0,250)]

func _ready():
	#calculate our weight total, will be used to get probabilty
	weight_total = 0
	for i in bait_weights:
		weight_total += i
	
	if StateManager.bait_enabled:
		#begin the timer with a random value in our range
		timer.start(randf_range(min_spawn_time, max_spawn_time)) 
	

func spawn(index):
	var b = bait_scenes[index].instantiate()
	add_child(b)
	b.position = spawn_positions[randi_range(0,3)]

func _on_timer_timeout():
	#random float to decided which bait to spawn
	var seed = randf_range(0,1)
	var prob = 0
	for i in range(0, bait_weights.size()):
		prob += bait_weights[i] / weight_total
		if seed < prob:
			spawn(i)
			break
	
	#start timer again to trigger next bait
	timer.start(randf_range(min_spawn_time, max_spawn_time))
