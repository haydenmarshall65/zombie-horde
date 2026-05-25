class_name Hurtbox
extends Area2D

signal is_hit(hitbox: Area2D)

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Area2D):
	if hitbox == null:
		return
	
	is_hit.emit(hitbox)
