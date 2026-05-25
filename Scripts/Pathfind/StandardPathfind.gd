class_name StandardPathfind extends PathfindAlgorithm

func pathfind(delta: float):
	# get the location of _target and find the angle the player is away from them
	# use that angle to determine the type of vector to add to the _entity's current
	# location.
	if !_target:
		return
	
	var direction = entity.global_position.direction_to(_target.global_position).normalized()
	
	var movement = direction * speed * 0.75
	
	entity.global_position += movement * delta
	
	entity.move_and_slide()
