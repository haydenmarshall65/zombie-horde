class_name Player extends CharacterBody2D

## The Player is the main character, controlled by the player. It has a hurtbox, collider, and a hitbox.

## The player's health.
@export var health: int = 3
## The player's invulnerability timer for when they are hit.
var _hurt_time: float = 0
## The direction the player is facing (See `PlayerWalkingState` for more info).
@export var direction: String = "down"

## A constant for the hitbox position when facing up
var HITBOX_UP_POSITION: Vector2 = Vector2(0, -8)
## A constant for the hitbox position when facing down
var HITBOX_DOWN_POSITION: Vector2 = Vector2(0, 8)
## A constant for the hitbox position when facing left
var HITBOX_LEFT_POSITION: Vector2 = Vector2(-6, 0)
## A constant for the hitbox position when facing right
var HITBOX_RIGHT_POSITION: Vector2 = Vector2(6, 0)

## On ready, connect the hitbox's `is_hit` signal to `_on_hit`
func _ready() -> void:
	$BodyHurtbox.is_hit.connect(_on_hit)

## If the attack button is pressed, enable the attacking hitbox
## Check each collision. If one of them is a Zombie, take away one health
## and reset the invulnerability timer.
## While the invulnerability timer is above 0, the player's hitbox is disabled
## and `delta` is reduced from it. Once it is at or below 0, the player's hitbox
## is reenabled. 
## If the player loses all 4 lives, they are removed.
func _process(delta: float) -> void:
	
	_handle_hitbox()
	
	if health < 0:
		queue_free()
	
	if _hurt_time > 0:
		$BodyHurtbox/BodyShape.set_deferred("disabled", true)
		_hurt_time -= delta
	else:
		$BodyHurtbox/BodyShape.set_deferred("disabled", false)
		_hurt_time = 0

func _handle_hitbox():
	if Input.is_action_pressed("attack"):
		$AttackingHitbox/AttackingHitboxShape.set_deferred("disabled", false)
	else:
		$AttackingHitbox/AttackingHitboxShape.set_deferred("disabled", true)
	
	# depending on the position the player is facing, move the hitbox
	match direction:
		"up":
			$AttackingHitbox.position = HITBOX_UP_POSITION
			$AttackingHitbox/AttackingHitboxShape.position = HITBOX_UP_POSITION
		"down":
			$AttackingHitbox.position = HITBOX_DOWN_POSITION
			$AttackingHitbox/AttackingHitboxShape.position = HITBOX_DOWN_POSITION
		"left":
			$AttackingHitbox.position = HITBOX_LEFT_POSITION
			$AttackingHitbox/AttackingHitboxShape.position = HITBOX_LEFT_POSITION
		"right":
			$AttackingHitbox.position = HITBOX_RIGHT_POSITION
			$AttackingHitbox/AttackingHitboxShape.position = HITBOX_RIGHT_POSITION

## When the player gets hit, take away one health and reset the invulnerability timer.
func _on_hit(hitbox: Area2D):
	if hitbox.name == "ZombieHitbox":
		_hurt_time = 1
		health -= 1
