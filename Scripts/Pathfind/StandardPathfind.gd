class_name StandardPathfind extends PathfindAlgorithm

func pathfind(delta: float) -> void:
	# get the location of _target and find the angle the player is away from them
	# use that angle to determine the type of vector to add to the _entity's current
	# location.
	if !_target:
		print("No target");
		return
	
	var direction: Vector2 = entity.global_position.direction_to(_target.global_position).normalized()
	
	var movement: Vector2 = direction * speed * 0.75
	
	entity.global_position += movement * delta
	
	entity.move_and_slide()
