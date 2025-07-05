extends Node2D

@export var enemy : PackedScene
@export var amount : int
@export var interval : float
@export var location_override : Vector2
@export var wait : bool
@export var invisible : bool
@export var gridlocked : bool
@export var collision : bool
@export var stats : Dictionary
@export var spawn_area : CollisionShape2D
