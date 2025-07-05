extends Node

@export var radius : float

@onready var enemy = get_parent()

func _physics_process(delta):
	if !enemy.is_in_group("enemy") or enemy.global_position.distance_to(Global.player.global_position) > radius:
		return
	
