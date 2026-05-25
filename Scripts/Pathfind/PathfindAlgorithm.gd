class_name PathfindAlgorithm extends Node

@export var speed: int
@export var entity: CharacterBody2D
var _target: CharacterBody2D

func pathfind(delta: float) -> void:
	pass

func set_target(target: CharacterBody2D) -> void:
	_target = target
