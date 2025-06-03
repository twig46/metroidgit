extends CharacterBody2D

var bullet_speed = 0

func _ready():
	$Projectile.visible = false
	$Projectile.disabled = true

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - get_parent().position
	position += mouse_vector.normalized() * bullet_speed * delta
	if Input.is_action_just_pressed("shoot"):
		$Projectile.visible = true
		bullet_speed = 100
		await get_tree().create_timer(3).timeout
		bullet_speed = 0
	move_and_slide()
