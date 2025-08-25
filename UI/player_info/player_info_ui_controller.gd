extends Control

@export var lives_images: Array[TextureRect]

@onready var fuel_progress_bar: ProgressBar = $HBoxContainer/VBoxContainer/Fuel
@onready var score_value_label: Label = $HBoxContainer/VBoxContainer/Score/Value
@onready var score_controller: ScoreController = $HBoxContainer/VBoxContainer/Score/Score
@onready var lives_counter: Counter = $HBoxContainer/Lives/Counter

func _ready() -> void:
	Signals.player_initialized.connect(init_ui)
	Signals.player_health_changed.connect(on_player_health_changed)
	Signals.player_fuel_changed.connect(on_player_fuel_changed)
	Signals.score_changed.connect(on_score_changed)

func init_ui(player_data: PlayerData) -> void:
	on_player_health_changed(player_data.health)
	on_player_fuel_changed(player_data.fuel)

func on_player_health_changed(current_health: int) -> void:
	lives_counter.update_value(current_health)

func on_player_fuel_changed(fuel_percent: float) -> void:
	fuel_progress_bar.value = fuel_percent * 100

func on_score_changed(current_score: int) -> void:
	score_controller.update_score(current_score)
	score_value_label.text = str(current_score)
