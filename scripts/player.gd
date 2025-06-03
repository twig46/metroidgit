extends CharacterBody2D

# define exportable variables
@export var speed := 400.0
@export var jump_force := 1000.0
@export var gengravity := 1600.0
@export var jumpgravity := 2000.0
@export var bounce_force := 100.0
@export var player_health := 100
@export var buffer_time := 0.2

# defien non-exportable variables
var is_running = true
var gamestart = false
var was_on_floor = false
var prev_velocity_y = 0.0
var jump_buffer : bool = false
var bounce = true
var held_duration : float = 0
@onready var sword = $Attacks/Sword

func _physics_process(delta: float) -> void:
	# equivelant of _ready() technically redundant
	if !gamestart:
		gamestart = true
		jumpy_jump()
		
	# left-right movement with 0 ice physics
	if Input.get_axis("left", "right") != 0:
		velocity.x = Input.get_axis("left", "right") * speed
	elif is_on_floor():
		velocity.x = 0
	var on_floor = is_on_floor()

	# double gravity handling
	if not on_floor:
		if velocity.y > 0:
			velocity.y += jumpgravity * delta
		else:
			velocity.y += gengravity * delta

	# jump buffer handling
	if on_floor and jump_buffer:
		jump_buffer = false
		velocity.y = -jump_force * $jumpbar.value / 3
	
	# bounce
	if on_floor and !was_on_floor and abs(prev_velocity_y) > 200 and bounce:
		print("bounce")
		velocity.y = -bounce_force*prev_velocity_y/400

	was_on_floor = on_floor
	prev_velocity_y = velocity.y
	
	# temporary sword
	if Input.is_action_just_pressed("sword"):
		if held_duration == 2.5:
			$Attacks.attack("big_sword", 1.5)
		else:
			$Attacks.attack("sword", 1)
	move_and_slide()
	

# jumps
func jumpy_jump():
	var explode : bool
	while true:
		bounce = true
		await get_tree().process_frame
		if Input.is_action_just_pressed("jump"):
			bounce = false
			$jumpbar.value = 0
			$jumpbar.visible = true
			while Input.is_action_pressed("jump"):
				await get_tree().create_timer(0.1).timeout
				held_duration += 0.1
				held_duration = clamp(held_duration, 0, 2.5)
				$jumpbar.value = held_duration
			print("Jump held for:", held_duration, "seconds")
			if held_duration < 1:
				held_duration = 1
			if held_duration == 2.5:
				explode = true
			if is_on_floor():
				velocity.y = -jump_force * held_duration / 2
				if explode:
					$anim.play("Boom")
					await $anim.animation_finished
					$anim.play("RESET")
				explode = false
			else:
				jump_buffer = true
				get_tree().create_timer(buffer_time).timeout.connect(buffer_timeout)
			held_duration = 0
			$jumpbar.visible = false

# buffer stuff
func buffer_timeout():
	bounce = true
	jump_buffer = false
