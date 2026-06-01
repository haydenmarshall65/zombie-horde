class_name ZombieSpawner extends Node

@export var spawn_position: Vector2 = Vector2(0, 0)
@export var health: int = 3
@export var spawn_interval: float = 1.0
@export var target: CharacterBody2D

var zombie_scene: PackedScene = preload("res://Scenes/Zombie.tscn")

func _ready() -> void:
	$SpawnTimer.wait_time = spawn_interval
	$SpawnTimer.connect("timeout", _spawn_zombie_on_timeout)
	$ZombieSpawnerHitbox.connect("is_hit", _on_ZombieSpawnerHitbox_area_entered)

func _process(delta: float) -> void:
	# todo add code to change the sprite based on health
	pass

func _spawn_zombie_on_timeout() -> void:
	# Spawn a zombie
	var zombie: Zombie = zombie_scene.instantiate()
	
	zombie.position = spawn_position
	
	zombie._target = target
	
	add_child(zombie)

func _on_ZombieSpawnerHitbox_area_entered(hitbox: Area2D) -> void:
	if hitbox.name == "AttackingHitbox":
		health -= 1
	
	if health == 0:
		queue_free()
