extends Node2D

@onready var settings = get_parent()
@onready var main = settings.get_parent()

@onready var enemy = settings.enemy
@onready var amount = settings.amount
@onready var interval = settings.interval
@onready var location_override = settings.location_override
@onready var wait = settings.wait
@onready var invisible = settings.invisible
@onready var gridlocked = settings.gridlocked
@onready var collision = settings.collision
@onready var stats = settings.stats
@onready var spawn_area = settings.spawn_area


func _ready():
	init_enemy()
	if gridlocked:
		grid_lock()
	if invisible:
		visible = false
	if !collision:
		$spawnbody/spawncollision.disabled = true

func set_values(guy):
	for s in stats:
		var name = s
		var value =  stats[s]
		guy.set(name, value)

func init_enemy():
	await get_tree().process_frame
	if amount > -1:
		for a in amount:
			await get_tree().create_timer(interval).timeout
			var nenemy = spawn_enemy()
			if wait and nenemy.has_signal("enemy_death"):
				await nenemy.enemy_death
	else:
		while true:
			await get_tree().create_timer(interval).timeout
			var nenemy = spawn_enemy()
			if wait and nenemy.has_signal("enemy_death"):
				await nenemy.enemy_death

func spawn_enemy():
	var nenemy = enemy.instantiate()
	set_values(nenemy)
	nenemy.global_position = global_position
	if location_override != Vector2.ZERO:
		nenemy.global_position = location_override
	else:
		var left_border = spawn_area.global_position.x - spawn_area.shape.size.x / 2
		var right_border = spawn_area.global_position.x + spawn_area.shape.size.x / 2
		var rand_spawn = Vector2(randf_range(left_border, right_border), spawn_area.global_position.y)
		nenemy.global_position = rand_spawn
	main.add_child(nenemy)
	return nenemy

func grid_lock():
	await get_tree().process_frame
	position.x = round(position.x/32)*32
	position.y = round(position.y/32)*32
	if position == Vector2.ZERO:
		position.x = 32
		position.y = 32
	print(position)
