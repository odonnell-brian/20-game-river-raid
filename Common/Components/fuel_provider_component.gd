class_name FuelProviderComponent
extends Area2D

@export var fuel_per_second: float = 10

var target: FuelComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(try_set_target)
	area_exited.connect(try_remove_target)

func _process(delta: float) -> void:
	if target:
		target.refuel(fuel_per_second * delta)

func try_set_target(node: Node2D) -> void:
	if not node is FuelComponent:
		return

	target = node as FuelComponent

func try_remove_target(node: Node2D) -> void:
	if target and node == target:
		target = null
