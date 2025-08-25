extends Node2D

@export var score_per_second: int = 10

var score: float

func _ready() -> void:
	Signals.score_earned.connect(on_score_earned)

func _process(delta: float) -> void:
	score += score_per_second * delta

func on_score_earned(amount: int) -> void:
	score += amount
	print("Current score: %d" % score)
