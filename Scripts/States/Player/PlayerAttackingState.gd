class_name PlayerAttackingState extends BaseState

@export var _hurtbox: CollisionShape2D

func on_enter_state():
	_hurtbox.disabled = false

func on_exit_state():
	_hurtbox.disabled = true

func update(delta: float):
	if _is_moving():
		Transitioned.emit(self, "playerwalkingstate")
		return
	
	if _is_moving() == false:
		Transitioned.emit(self, "playeridlestate")
		return
