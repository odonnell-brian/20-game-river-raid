class_name ScrollComponent
extends Node2D

enum ScreenExitBehavior {NONE, DESTROY, REPEAT}

const DESTROY_BUFFER_PIXELS: float = 50.0

@export var node_to_move: Node2D
@export var scroll_velocity: Vector2

@export var screen_exit_behavior: ScreenExitBehavior = ScreenExitBehavior.NONE
@export var visibility_notifier: VisibleOnScreenNotifier2D

var spawn_position: Vector2

func _ready() -> void:
	spawn_position = global_position

	if visibility_notifier:
		visibility_notifier.screen_exited.connect(on_screen_exited)

func _physics_process(delta: float) -> void:
	node_to_move.global_position += get_velocity() * delta

func on_screen_exited() -> void:
	match screen_exit_behavior:
		ScreenExitBehavior.DESTROY:
			node_to_move.queue_free()
		ScreenExitBehavior.REPEAT:
			node_to_move.global_position = spawn_position

func get_velocity() -> Vector2:
	return scroll_velocity
