extends Node

var player : Node2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
