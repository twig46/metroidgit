extends Node

func hit_flash(node: Node2D, damage: float) -> bool:
	if node.has_node("Sprite2D"):
		var sprite = node.get_node("Sprite2D")
		sprite.modulate = Color(10, 10, 10, 10)
		get_tree().paused = true
		await get_tree().create_timer(0.02*damage).timeout
		get_tree().paused = false
		if node != null:
			sprite.modulate = Color(1, 1, 1, 1)
		return true
	else:
		return false
