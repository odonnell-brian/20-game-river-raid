class_name AnimationComponent
extends Node

@export var movement_component: MovementComponent
@export var animation_player: AnimationPlayer

var current_animation: String = "RESET"

func update_animation() -> void:
	if not movement_component.movement_changed():
		return

	var animation_name: String = get_animation_for_movement(movement_component.movement)
	if current_animation != animation_name:
		animation_player.play(animation_name)
		current_animation = animation_name

func get_animation_for_movement(movement: Vector2) -> String:
	var animation_name: String
	if movement.x < 0:
		animation_name = "turn_left"
	elif movement.x > 0:
		animation_name = "turn_right"
	else:
		animation_name = "RESET"

	return animation_name
