extends CharacterBody2D

var health : int
var gravity : int
var knockback : int

signal enemy_death

func _ready():
	$healthbar.max_value = health
	$healthbar.value = health
	wall_check()

func enemy_take_damage(damage, direction: Vector2):
	health -= damage
	print(health)
	$healthbar.value = health
	velocity += direction * knockback
	fx.hit_flash(self, damage)
	if health < 1:
		enemy_death.emit()
		queue_free()
	await get_tree().create_timer(1.0).timeout
	velocity = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += gravity * delta
	if position.y > 2000:
		enemy_death.emit()
		queue_free()
	move_and_slide()
	
func wall_check():
	while true:
		if $left.is_colliding() or $right.is_colliding():
			pass
			#velocity = Vector2.ZERO
		await get_tree().create_timer(0.1).timeout
