extends Sprite2D

@onready var player = get_parent().get_parent()
var game_start = false

func _physics_process(delta: float) -> void:
	if !game_start:
		game_start = true
		_boom()
		
func _boom():
	while true:
		await get_tree().process_frame
		position = player.position
		while player.get_node("anim").is_playing() and player.get_node("anim").current_animation == "Boom":
			await get_tree().process_frame
