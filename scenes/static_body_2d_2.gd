extends StaticBody2D

var health = 100

func enemy_take_damage(damage):
	health -= damage
	if health < 1:
		queue_free()
