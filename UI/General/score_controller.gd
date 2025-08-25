class_name ScoreController
extends Control

var counters: Array[Counter]

func _ready() -> void:
	for child in $HBoxContainer.get_children():
		if child is Counter:
			counters.append(child as Counter)
			child.visible = false

func update_score(score: int) -> void:
	var score_string: String = str(score)
	for i in range(counters.size() - 1, -1, -1):
		var score_index = i - (counters.size() - score_string.length())
		if score_index >= 0 and score_index < score_string.length():
			counters[i].visible = true
			counters[i].update_value(int(score_string[score_index]))


# 34
# 0 1 2 3 4 5 6 7 8 9

# 0 1 2 -> 7 8 9
