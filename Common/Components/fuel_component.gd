class_name FuelComponent
extends Area2D

signal fuel_initialized()
signal fuel_changed(current_fuel_percent: float)

const MAX_FUEL: float = 100.0

@export var fuel_loss_per_second: float = 5.0
@export var health_component: HealthComponent
@export var health_loss_on_fuel_empty: int = 1

var current_fuel: float = MAX_FUEL

func _ready() -> void:
	Signals.scene_ready.connect(fuel_initialized.emit)

func _process(delta: float) -> void:
	current_fuel = max(0.0, current_fuel - (fuel_loss_per_second * delta))
	fuel_changed.emit(current_fuel / MAX_FUEL)

	if current_fuel <= 0.0:
		handle_empty()

func refuel(amount: float) -> void:
	current_fuel = minf(MAX_FUEL, current_fuel + amount)
	fuel_changed.emit(current_fuel / MAX_FUEL)

func handle_empty() -> void:
	health_component.take_damage(health_loss_on_fuel_empty)
	current_fuel = MAX_FUEL
