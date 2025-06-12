extends CharacterBody2D

@onready var player = get_parent().get_parent()

func shoot(bullet_speed):
	position = player.position
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - player.position
	velocity = mouse_vector.normalized() * bullet_speed
	await get_tree().create_timer(2).timeout
	queue_free()
	print("projectiled")
