class_name Player extends CharacterBody2D

@export var health: int = 3
var _hurt_time = 0
@export var direction: String = "down"

var HITBOX_UP_POSITION = Vector2(0, -8)
var HITBOX_DOWN_POSITION = Vector2(0, 8)
var HITBOX_LEFT_POSITION = Vector2(-6, 0)
var HITBOX_RIGHT_POSITION = Vector2(6, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BodyHurtbox.is_hit.connect(_on_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# If the attack button is pressed, enable the attacking hitbox
	# Check each collision. If one of them is a Zombie, take away one health
	# and reset the invulnerability timer.
	# While the invulnerability timer is above 0, the player's hitbox is disabled
	# and `delta` is reduced from it. Once it is at or below 0, the player's hitbox
	# is reenabled. 
	# If the player loses all 4 lives, they are removed.
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
	# left: -15, 0. right: 15, 0. up: 0, -15. down: 0, 15
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

func _on_hit(hitbox: Area2D):
	if hitbox.name == "ZombieHitbox":
		_hurt_time = 1
		health -= 1
