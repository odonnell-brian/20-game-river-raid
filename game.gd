extends Node2D

@export var score_per_second: int = 10

var score: float

func _ready() -> void:
	Signals.score_earned.connect(on_score_earned)
	Signals.scene_ready.emit()

func _process(delta: float) -> void:
	on_score_earned(score_per_second * delta)

func on_score_earned(amount: float) -> void:
	score += amount
	Signals.score_changed.emit(score)
