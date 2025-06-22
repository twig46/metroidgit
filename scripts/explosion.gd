extends AnimatedSprite2D

@onready var player = get_parent().get_parent()

func _ready():
	_boom()

func _boom():
	while true:
		await get_tree().process_frame
		visible = false
		position = player.position
		while is_playing():
			visible = true
			print("boom")
			await get_tree().process_frame
