class_name FuelComponent
extends Area2D

signal fuel_changed(current_fuel_percent: float)

const MAX_FUEL: float = 100.0

@export var fuel_loss_per_second: float = 5.0

var current_fuel: float = MAX_FUEL

func _process(delta: float) -> void:
	current_fuel = max(0.0, current_fuel - (fuel_loss_per_second * delta))

func refuel(amount: float) -> void:
	current_fuel = minf(MAX_FUEL, current_fuel + amount)
	fuel_changed.emit(current_fuel / MAX_FUEL)
