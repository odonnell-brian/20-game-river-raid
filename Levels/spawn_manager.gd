class_name SpawnManager
extends Node2D

const fuel_scene: PackedScene = preload("res://Entities/fuel/fuel.tscn")
const bridge_scene: PackedScene = preload("res://Entities/bridge/bridge.tscn")
const enemy_scenes: Array[PackedScene] = [
	preload("res://Entities/enemy_ship/enemy_ship.tscn"),
	preload("res://Entities/enemy_ship/enemy_ship2.tscn")
]
const ufo_scene = preload("res://Entities/enemy_ufo/enemy_ufo.tscn")

@export var ufo_spawn_time_range: Vector2 = Vector2(10.0, 30.0)

@onready var ufo_timer: Timer = $UfoTimer

var ufo_spawn_position: Vector2

func _init() -> void:
	GlobalData.spawn_manager = self

func _ready() -> void:
	Signals.level_pieces_added.connect(spawn_entities)
	Signals.reset_level_segment.connect(on_reset_level_segment)

	# TODO: randomize spawn position
	ufo_spawn_position = Vector2(get_viewport().size.x + 100, 200.0)
	ufo_timer.timeout.connect(spawn_ufo)
	start_ufo_timer()

func spawn_entities(level_pieces: Array[LevelPiece]) -> void:
	for i in range(level_pieces.size() - 1):
		var level_piece: LevelPiece = level_pieces[i]
		spawn_entity_at_markers(level_piece.fuel_spawns, [fuel_scene])
		spawn_entity_at_markers(level_piece.enemy_spawns, enemy_scenes)

	var last_piece: LevelPiece = level_pieces[level_pieces.size() - 1]
	spawn_entity(last_piece.bridge_spawn.global_position, bridge_scene)
	last_piece.is_bridge_piece = true

func spawn_entity_at_markers(markers: Array[Marker2D], scenes: Array[PackedScene]) -> void:
	for marker in markers:
		spawn_entity(marker.global_position, scenes[randi_range(0, scenes.size() - 1)])

func spawn_entity(spawn_position: Vector2, scene: PackedScene) -> void:
	var entity = scene.instantiate() as Node2D
	entity.global_position = spawn_position
	call_deferred("add_child", entity)

func spawn_ufo() -> void:
	spawn_entity(ufo_spawn_position, ufo_scene)
	start_ufo_timer()

func start_ufo_timer() -> void:
	ufo_timer.start(randf_range(ufo_spawn_time_range.x, ufo_spawn_time_range.y))

func on_reset_level_segment() -> void:
	for child in get_children():
		child.call_deferred("queue_free")

	pass
