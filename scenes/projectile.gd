extends CharacterBody2D

var pos = get_node("/root/Node2D/Player/Frog").position

func _ready():
	$Projectile.visible = false

func _physics_process(delta: float) -> void:
	global_position = Vector2(pos.x, pos.y)
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - get_parent().position
	if Input.is_action_just_pressed("shoot"):
		$Projectile.visible = true
