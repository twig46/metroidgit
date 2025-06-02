extends ProgressBar

func _ready():
	visible = false
	vibrate_check()
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ffff00")

func vibrate_check():
	while true:
		await get_tree().process_frame
		position = Vector2(35, -19)
		if value == 2.5:
			print("vibration")
			position.x = randf_range(position.x-3, position.x+3)
			position.y = randf_range(position.y-3, position.y+3)
			
	
