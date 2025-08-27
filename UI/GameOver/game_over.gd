extends Control

@onready var restart_button: Button = $PanelContainer/VBoxContainer/Button

func _ready() -> void:
	Signals.game_over.connect(show.unbind(1))
	restart_button.pressed.connect(Signals.restart_game.emit)
