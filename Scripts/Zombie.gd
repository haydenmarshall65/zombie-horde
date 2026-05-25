extends CharacterBody2D

@export var _target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StandardPathfind.set_target(_target)
	$ZombieHitbox.is_hit.connect(_on_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$StandardPathfind.pathfind(delta)

func _on_hit(hitbox: Area2D):
	if hitbox.name == "AttackingHitbox":
		queue_free()
