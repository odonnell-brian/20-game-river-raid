extends Node2D

@export var health_component: HealthComponent

func _ready() -> void:
	health_component.health_depleted.connect(Signals.bridge_destroyed.emit)
