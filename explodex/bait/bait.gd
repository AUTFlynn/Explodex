extends CharacterBody2D
class_name bait

@export var only_bombs : bool = false
@export var only_flag : bool = false
@export var num_targets : int = 3
@export var speed : float = 40
var targets = []

const min_distance = 10


func _physics_process(delta):
	if targets.size() > 0:
		var direction = position.direction_to(targets[0])
		velocity = direction * speed
		move_and_slide()
		
		if position.distance_to(targets[0]) < min_distance:
			targets.pop_front()


func _on_timer_timeout():
	while targets.size() < num_targets+1:
		var tiles = StateManager.world.tiles
		var board_size = StateManager.board_size
		var pos =Vector2i(randi_range(0,board_size.x), randi_range(0,board_size.y))
		if tiles.has(pos):
			var t = tiles[pos]
			targets.append(t.position)
