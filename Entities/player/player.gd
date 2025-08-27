class_name Player
extends CharacterBody2D

@export_category("Components")
@export var animation_component: AnimationComponent
@export var movement_component: MovementComponent
@export var acceleration_component: AccelerationComponent
@export var health_component: HealthComponent
@export var fuel_component: FuelComponent

@onready var hit_animation_player: AnimationPlayer = $HitAnimations

func _ready() -> void:
	health_component.health_changed.connect(on_health_changed)
	health_component.health_depleted.connect(on_health_depleted)
	fuel_component.fuel_changed.connect(Signals.player_fuel_changed.emit)

	var player_data: PlayerData = PlayerData.new(health_component.current_health, fuel_component.current_fuel)
	Signals.scene_ready.connect(Signals.player_initialized.emit.bind(player_data))

func _physics_process(delta: float) -> void:
	animation_component.update_animation()
	movement_component.update_velocity(self, delta)

	if acceleration_component.handle_acceleration(delta):
		Signals.player_vertical_acceleration_changed.emit(acceleration_component.current_acceleration)
		GlobalData.player_velocity_percent = acceleration_component.current_acceleration

	move_and_slide()

func on_health_changed(current_health: int) -> void:
	hit_animation_player.play("blink")
	Signals.player_health_changed.emit(current_health)

func on_health_depleted() -> void:
	Signals.player_destroyed.emit()

func on_fuel_changed(fuel_percent: float) -> void:
	print(fuel_percent)
