extends CharacterBody2D

var dir : Vector2
var speed = 400
var damage = 10

func _ready():
	position = Global.player.position
	velocity = dir * speed
	death_timer()

func death_timer():
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta):
	move_and_slide()

func _on_collide(body: Node2D) -> void:
	print("Collided with: ", body)
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage, dir * -1)
	queue_free()
