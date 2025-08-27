class_name DestroyTimer
extends Node2D

@export var time_to_destroy: float = 1.0

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	timer.start(time_to_destroy)

func on_timer_timeout() -> void:
	get_parent().queue_free()
