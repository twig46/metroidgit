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
	
	velocity.x = Input.get_axis("left", "right") * speed

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
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("jump"):
			var press_time = Time.get_unix_time_from_system()
			while Input.is_action_pressed("jump"):
				await get_tree().process_frame
			var release_time = Time.get_unix_time_from_system()
			var held_duration = release_time - press_time
			print("Jump held for:", held_duration, "seconds")
			if held_duration < 0.4:
				held_duration = 0.4
			if held_duration > 3.0:
				queue_free()
			if is_on_floor():
				velocity.y = -jump_force * clamp(held_duration, 0, 0.7)
			
			



			
			
