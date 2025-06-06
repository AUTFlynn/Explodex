extends CharacterBody2D
class_name bait

@export var only_bombs : bool = false
@export var only_flag : bool = false
@export var num_targets : int = 3

@export var speed : float = 40
@export var acceleration: float = 50

var targets = []
var target_tiles = []
const end_positions = [Vector2(-250, 0), Vector2(250, 0), Vector2(0, -250), Vector2(0,250)]
var end_index : int
const min_distance = 10

func _ready():
	end_index = randi_range(0,3) #select a random end point
	
	while targets.size() < num_targets+1:
		var tiles = StateManager.world.tiles
		var board_size = StateManager.board_size
		var pos = Vector2i(randi_range(0,board_size.x), randi_range(0,board_size.y))
		if tiles.has(pos):
			var t = tiles[pos]
			target_tiles.append(t)
			targets.append(t.position)

func _physics_process(delta):
	#move sequentially to the targets in our array
	if targets.size() > 0:
		var direction = position.direction_to(targets[0])
		var new_velocity = direction * speed
		
		velocity = velocity.move_toward(new_velocity, acceleration * delta)
		move_and_slide()
		
		if position.distance_to(targets[0]) < min_distance:
			var t = target_tiles.pop_front()
			target_reached(t)
			targets.pop_front()
	else: #we have succesfully gone to all targets
		#target out exit position
		var direction = position.direction_to(end_positions[end_index])
		var new_velocity = direction * speed
		
		velocity = velocity.move_toward(new_velocity, acceleration * delta)
		move_and_slide()
		
		#delete if we reach it
		if position.distance_to(end_positions[end_index]) < min_distance:
			die()

func die():
	queue_free()
	
func target_reached(target):
	pass
