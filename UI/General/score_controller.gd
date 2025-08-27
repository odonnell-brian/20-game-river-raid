class_name ScoreController
extends Control

@export var preview_score: int = 999999

var counters: Array[Counter]

func _ready() -> void:
	for child in $HBoxContainer.get_children():
		if child is Counter:
			counters.append(child as Counter)
			child.visible = false

	Signals.game_over.connect(update_score)

func update_score(score: int) -> void:
	var score_string: String = str(score)
	for i in range(counters.size() - 1, -1, -1):
		var score_index = i - (counters.size() - score_string.length())
		if score_index >= 0 and score_index < score_string.length():
			counters[i].visible = true
			counters[i].update_value(int(score_string[score_index]))
