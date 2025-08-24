class_name ScrollComponent
extends Node2D

const DESTROY_BUFFER_PIXELS: float = 50.0

@export var node_to_move: Node2D
@export var scroll_velocity: Vector2

@export var visibility_notifier: VisibleOnScreenNotifier2D

func _ready() -> void:
	if visibility_notifier:
		visibility_notifier.screen_exited.connect(on_screen_exited)

func _physics_process(delta: float) -> void:
	node_to_move.global_position += scroll_velocity * delta

func on_screen_exited() -> void:
	node_to_move.queue_free()
