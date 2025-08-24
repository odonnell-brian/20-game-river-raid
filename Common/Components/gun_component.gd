class_name GunComponent
extends Node

@export var projectile_spawn_marker: Marker2D
@export var projectile_entity: PackedScene
@export var cooldown_timer: Timer

var can_shoot: bool = true

func _ready() -> void:
	cooldown_timer.timeout.connect(on_cooldown_timeout)

func _process(_delta: float) -> void:
	try_shoot()

func try_shoot() -> void:
	if not Input.is_action_pressed("shoot") or not can_shoot:
		return

	var projectile = projectile_entity.instantiate() as Node2D
	projectile.global_position = projectile_spawn_marker.global_position
	get_tree().current_scene.add_child(projectile)

	can_shoot = false
	cooldown_timer.start()

func on_cooldown_timeout() -> void:
	can_shoot = true
