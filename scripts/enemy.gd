extends StaticBody2D

var health = 100

func _ready():
	$healthbar.max_value = health
	$healthbar.value = health

func enemy_take_damage(damage):
	health -= damage
	print(health)
	$healthbar.value = health
	fx.hit_flash(self, damage)
	if health < 1:
		queue_free()
