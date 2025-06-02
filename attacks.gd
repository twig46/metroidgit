extends Area2D

var dash_speed = 10.0

func _physics_process(delta: float) -> void:
		var mouse_pos = get_global_mouse_position()
		var mouse_vector = mouse_pos - get_parent().position
		rotation = mouse_vector.angle()
		$Sprite2D.rotation = -mouse_vector.angle()
		
		if Input.is_action_just_pressed("dash"):
			get_parent().velocity = Vector2.ZERO
			get_parent().velocity += mouse_pos * dash_speed

func _on_hit(body : Node2D):
	if body.is_in_group("enemy"):
		body.queue_free()
