class_name PlayerIdleState extends BaseState

func on_enter_state():
	# add code for beginning the Idle animation
	pass

func on_exit_state():
	pass

func update(_delta: float):
	if _is_moving() == true:
		Transitioned.emit(self, "playerwalkingstate")
