extends AnimationPlayer

func _physics_process(delta):
	if get_parent().velocity.x != 0:
		play("walk")
	else:
		play("RESET")
