class_name Player
extends CharacterBody2D

@export_category("Components")
@export var animation_component: AnimationComponent
@export var movement_component: MovementComponent
@export var acceleration_component: AccelerationComponent
@export var health_component: HealthComponent

@onready var hit_animation_player: AnimationPlayer = $HitAnimations

func _ready() -> void:
	health_component.health_changed.connect(on_health_changed)
	health_component.health_depleted.connect(on_health_depleted)

func _physics_process(delta: float) -> void:
	animation_component.update_animation()
	movement_component.update_velocity(self, delta)

	if acceleration_component.handle_acceleration(delta):
		Signals.player_vertical_acceleration_changed.emit(acceleration_component.current_acceleration)

	move_and_slide()

func on_health_changed(current_health: int) -> void:
	print("current health %d" % current_health)
	hit_animation_player.play("blink")
	Signals.player_health_changed.emit(current_health)

func on_health_depleted(current_health: int) -> void:
	print("current health %d" % current_health)
	Signals.player_destroyed.emit()
