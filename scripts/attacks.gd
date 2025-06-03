extends Area2D

var projectile = preload("res://scenes/projectile.tscn")
@onready var player = get_parent()

@export var dash_speed = 1000.0
@export var attack_damage : float = 10

func _physics_process(delta: float) -> void:
		var mouse_pos = get_global_mouse_position()
		var mouse_vector = mouse_pos - player.position
		var cardinal_vector = Vector2(round(mouse_vector.normalized().x), round(mouse_vector.normalized().y))
		rotation = cardinal_vector.angle()
		$Sprite2D.rotation = -cardinal_vector.angle()
		
		if Input.is_action_just_pressed("dash"):
			player.velocity = Vector2(dash_speed,10).rotated(mouse_vector.angle())
			player.move_and_slide()

func _on_hit(body : Node2D):
	if body.is_in_group("enemy"):
		body.enemy_take_damage(attack_damage)
		attack_damage = 10

func attack(attack, mult):
	attack_damage = attack_damage * mult
	if attack == "sword":
		$Sword.visible = true
		$Sword.disabled = false
		for i in 5:
			await get_tree().process_frame
		$Sword.visible = false
		$Sword.disabled = true
	elif attack == "big_sword":
		get_parent().held_duration = 0.0
		$Sword.scale = Vector2(2,2)
		await attack("sword", 1.5)
		print("held for:", get_parent().held_duration)
		$Sword.scale = Vector2.ONE
	elif attack == "projectile":
		var newpro = projectile.instantiate()
		player.get_node("Independents").add_child(newpro)
		newpro.position = player.position
		newpro.velocity = player.velocity
		print("projectiled")
		newpro.move_and_slide()
		
