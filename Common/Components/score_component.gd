class_name ScoreComponent
extends Node2D

@export var health_component: HealthComponent
@export var score_amount: int

func _ready() -> void:
	health_component.health_depleted.connect(on_health_depleted)

func on_health_depleted() -> void:
	Signals.score_earned.emit(score_amount)
