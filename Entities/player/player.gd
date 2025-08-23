class_name Player
extends CharacterBody2D

@export_category("Components")
@export var animation_component: AnimationComponent
@export var movement_component: MovementComponent

func _physics_process(delta: float) -> void:
	animation_component.update_animation()
	movement_component.update_velocity(self, delta)
	move_and_slide()
