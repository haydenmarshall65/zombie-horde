class_name BaseState extends Node

@export var _player: CharacterBody2D
@export var _hitbox: CollisionShape2D

signal Transitioned

func on_enter_state():
	pass
	
func on_exit_state():
	pass
	
func update(delta: float):
	pass
	
func _is_moving() -> bool:
	return Input.is_action_pressed("move_down") or  Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
		
func _is_idle(movementVector: Vector2) -> bool:
	return movementVector == Vector2.ZERO and Input.is_action_pressed("attack") == false
