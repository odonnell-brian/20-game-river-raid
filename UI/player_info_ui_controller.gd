extends Control

@onready var fuel_value_label: Label = $HBoxContainer/VBoxContainer/Fuel/Value
@onready var score_value_label: Label = $HBoxContainer/VBoxContainer/Score/Value
@onready var lives_label: Label = $HBoxContainer/Lives/Value

func _ready() -> void:
	Signals.player_initialized.connect(init_ui)
	Signals.player_health_changed.connect(on_player_health_changed)
	Signals.player_fuel_changed.connect(on_player_fuel_changed)
	Signals.score_changed.connect(on_score_changed)

func init_ui(player_data: PlayerData) -> void:
	print("Health: %d" % player_data.health)
	print("Fuel: %d" % player_data.fuel)

func on_player_health_changed(current_health: int) -> void:
	lives_label.text = str(current_health)

func on_player_fuel_changed(fuel_percent: float) -> void:
	fuel_value_label.text = str(ceili(fuel_percent * 100))

func on_score_changed(current_score: int) -> void:
	score_value_label.text = str(current_score)
