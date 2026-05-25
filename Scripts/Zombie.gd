class_name Zombie extends CharacterBody2D

## The Zombie is a CharacterBody2D that chases the player and handles getting hit by the player.
## It utilizes a PathfindAlgorithm to move towards the player and a Hurtbox to detect when the zombie gets hit.

## Whatever the PathfindAlgorithm should cause the zombie to move towards.
@export var _target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StandardPathfind.set_target(_target)
	$ZombieHitbox.is_hit.connect(_on_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$StandardPathfind.pathfind(delta)

## When the zombie gets hit, it is removed from the scene.
func _on_hit(hitbox: Area2D):
	if hitbox.name == "AttackingHitbox":
		queue_free()
