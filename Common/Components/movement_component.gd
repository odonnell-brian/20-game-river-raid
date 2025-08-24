class_name MovementComponent
extends Node

@export var max_speed: Vector2 = Vector2(200, 0)

var movement: Vector2 = Vector2.ZERO
var previous_movement: Vector2 = Vector2.ZERO

func update_velocity(body: CharacterBody2D, _delta: float) -> void:
	previous_movement = movement
	movement = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	body.velocity = movement * max_speed

func movement_changed() -> bool:
	return movement != previous_movement
