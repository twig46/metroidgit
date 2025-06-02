extends CharacterBody2D

@export var speed := 400.0
@export var jump_force := 1500.0
@export var gengravity := 1600.0
@export var jumpgravity := 2000.0
@export var bounce_force := 100.0

var is_running = true
var gamestart = false
var was_on_floor = false
var prev_velocity_y = 0.0
@onready var sword = $Attacks/Sword

func _physics_process(delta: float) -> void:
	
	if !gamestart:
		gamestart = true
		jumpy_jump()
	if Input.get_axis("left", "right") != 0:
		velocity.x = Input.get_axis("left", "right") * speed
	elif is_on_floor():
		velocity.x = 0
	var on_floor = is_on_floor()

	if not on_floor:
		if velocity.y > 0:
			velocity.y += jumpgravity * delta
		else:
			velocity.y += gengravity * delta

	# Add bounce on landing
	if on_floor and !was_on_floor and abs(prev_velocity_y) > 200:
		print("bounce")
		velocity.y = -bounce_force*prev_velocity_y/400

	was_on_floor = on_floor
	prev_velocity_y = velocity.y
	
	if Input.is_action_pressed("sword"):
		sword.visible = true
		sword.disabled = false
	else:
		sword.visible = false
		sword.disabled = true

	move_and_slide()

func jumpy_jump():
	var explode : bool
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("jump"):
			var press_time = Time.get_unix_time_from_system()
			while Input.is_action_pressed("jump"):
				await get_tree().process_frame
			var release_time = Time.get_unix_time_from_system()
			var held_duration = release_time - press_time
			print("Jump held for:", held_duration, "seconds")
			if held_duration < 0.3:
				held_duration = 0.6
			if held_duration > 3.0:
				held_duration = 3
				explode = true
			if is_on_floor():
				velocity.y = -jump_force * held_duration / 2
				if explode:
					$anim.play("Boom")
					await $anim.animation_finished
					explode = false
					$anim.play("RESET")
			else:
				explode = false
			
			



			
			
