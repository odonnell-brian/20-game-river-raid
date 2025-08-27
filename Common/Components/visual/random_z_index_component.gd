class_name RandomZIndexComponent
extends Node2D

@export var z_range: Vector2i = Vector2i(-1, 1)

func on_init() -> void:
	(get_parent() as Node2D).z_index = randi_range(z_range.x, z_range.y)
