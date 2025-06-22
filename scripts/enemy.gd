extends CharacterBody2D

var health : int
var gravity : int
var knockback : int

signal enemy_death

func _ready():
	$healthbar.max_value = health
	$healthbar.value = health

func enemy_take_damage(damage, node: Node2D):
	health -= damage
	print(health)
	$healthbar.value = health
	var direction = ((node.mouse_vector).normalized())
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
	move_and_slide()
