extends Node2D

@export var enemy : PackedScene
@export var amount : int
@export var interval : float
@export var wait : bool
@export var stats : Dictionary

@onready var main = get_parent()

func _ready():
	init_enemy()

func set_values(guy):
	for s in stats:
		var name = s
		var value =  stats[s]
		guy.set(name, value)

func init_enemy():
	await get_tree().process_frame
	if amount > -1:
		for a in amount:
			var nenemy = spawn_enemy()
			if wait and nenemy.has_signal("enemy_death"):
				await nenemy.enemy_death
			await get_tree().create_timer(interval).timeout
	else:
		while true:
			print("looped")
			var nenemy = spawn_enemy()
			if wait and nenemy.has_signal("enemy_death"):
				await nenemy.enemy_death
			await get_tree().create_timer(interval).timeout


func spawn_enemy():
	var nenemy = enemy.instantiate()
	set_values(nenemy)
	nenemy.global_position = global_position
	main.add_child(nenemy)
	return nenemy
