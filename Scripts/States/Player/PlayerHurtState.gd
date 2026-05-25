class_name PlayerHurtState extends BaseState

### UNUSED

var _hurt_time: float = 1
@export var knockback: Vector2

func on_enter_state():
	_hurt_time = 1
	_player.health -= 1
	if _player.health < 0:
		queue_free()

func on_exit_state():
	pass
	
func update(delta: float):
	if _hurt_time > 0:
		_hurt_time -= delta
	else:
		Transitioned.emit(self, "PlayerIdleState")
		
	_player.position += knockback
	_player.move_and_slide()
	# code to disable hitbox
