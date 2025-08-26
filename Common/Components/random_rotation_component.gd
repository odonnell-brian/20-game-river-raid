class_name RandomRotationComponent
extends Node2D

@export var rotation_per_second_range: Vector2 = Vector2(50, 150)

var rotation_per_second: float
var direction: int = 1

func _ready() -> void:
	rotation_per_second = randf_range(rotation_per_second_range.x, rotation_per_second_range.y)
	direction = 1 if randi() % 2 == 0 else -1

func _physics_process(delta: float) -> void:
	(get_parent() as Node2D).rotation_degrees += (rotation_per_second * delta * direction)
