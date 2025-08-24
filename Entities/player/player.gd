class_name Player
extends CharacterBody2D

@export_category("Components")
@export var animation_component: AnimationComponent
@export var movement_component: MovementComponent
@export var acceleration_component: AccelerationComponent

func _physics_process(delta: float) -> void:
	animation_component.update_animation()
	movement_component.update_velocity(self, delta)

	if acceleration_component.handle_acceleration(delta):
		Signals.player_vertical_acceleration_changed.emit(acceleration_component.current_acceleration)

	move_and_slide()
