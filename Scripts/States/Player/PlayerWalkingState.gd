class_name PlayerWalkingState extends BaseState

@export var speed: int = 400

func on_enter_state():
	pass

func on_exit_state():
	pass

func update(delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	_player.position += input_direction * speed * delta
	
	# if the y is either -1 or 1, or just not 0, then the player is moving up or down, whether at an angle or straight.
	# Otherwise, if the x is not 0, then the player is moving left or right.
	if input_direction.y == -1 or (input_direction.y < 0 and input_direction.x != 0):
		_player.direction = "up"
	elif input_direction.y == 1 or (input_direction.y > 0 and input_direction.x != 0):
		_player.direction = "down"
	elif input_direction.x == -1:
		_player.direction = "left"
	elif input_direction.x == 1:
		_player.direction = "right"
	
	if _is_idle(input_direction):
		Transitioned.emit(self, "playeridlestate")
		return
	
	_player.move_and_slide()
