extends Node2D

@export var score_per_second: int = 20

@onready var world_node: Node2D = $World

var score: float

func _ready() -> void:
	Signals.score_earned.connect(on_score_earned)
	Signals.player_destroyed.connect(on_game_over)
	Signals.player_health_changed.connect(Signals.reset_level_segment.emit.unbind(1))
	Signals.restart_game.connect(on_restart_game)
	Signals.scene_ready.emit()

func _process(delta: float) -> void:
	if not get_tree().paused:
		on_score_earned(score_per_second * delta)

func on_score_earned(amount: float) -> void:
	score += amount
	Signals.score_changed.emit(score)

func on_restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func on_game_over() -> void:
	Signals.game_over.emit(score)
	get_tree().paused = true
