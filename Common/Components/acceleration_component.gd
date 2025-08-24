class_name AccelerationComponent
extends Node

const ACCELERATION_LIMITS: Vector2 = Vector2(0.0, 1.0)

@export var movement_component: MovementComponent
@export var time_to_max: float = 2.0
@export var sprites_to_fade: Array[Sprite2D]

var current_acceleration: float = 0.5

func _ready() -> void:
	update_sprites()

func handle_acceleration(delta: float) -> bool:
	if movement_component.movement.y == 0:
		return false

	var prev_acceleration: float = current_acceleration
	var acceleration_step = ((ACCELERATION_LIMITS.y - ACCELERATION_LIMITS.x) / time_to_max) * delta
	var acceleration_target = ACCELERATION_LIMITS.x if movement_component.movement.y > 0 else ACCELERATION_LIMITS.y
	current_acceleration = move_toward(clampf(current_acceleration, ACCELERATION_LIMITS.x, ACCELERATION_LIMITS.y), acceleration_target, acceleration_step)

	update_sprites()

	return prev_acceleration != current_acceleration

func update_sprites() -> void:
	for sprite: Sprite2D in sprites_to_fade:
		sprite.modulate.a = current_acceleration
