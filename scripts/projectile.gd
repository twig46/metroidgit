extends CharacterBody2D

var dir : Vector2
var speed = 1000

func _ready():
	position = Global.player.position
	velocity = dir * speed
	

func _physics_process(delta):
	move_and_slide()
