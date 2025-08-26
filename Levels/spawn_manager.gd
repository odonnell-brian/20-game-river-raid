class_name SpawnManager
extends Node2D

const fuel_scene: PackedScene = preload("res://Entities/fuel/fuel.tscn")
const bridge_scene: PackedScene = preload("res://Entities/bridge/bridge.tscn")
const enemy_scenes: Array[PackedScene] = [preload("res://Entities/enemy_ufo/enemy_ufo.tscn")]

func _ready() -> void:
	Signals.level_pieces_added.connect(spawn_entities)

func spawn_entities(level_pieces: Array[LevelPiece]) -> void:
	for i in range(level_pieces.size() - 1):
		var level_piece: LevelPiece = level_pieces[i]
		spawn_entity_at_markers(level_piece.fuel_spawns, [fuel_scene])
		spawn_entity_at_markers(level_piece.enemy_spawns, enemy_scenes)

	spawn_entity(level_pieces[level_pieces.size() - 1].bridge_spawn.global_position, bridge_scene)

func spawn_entity_at_markers(markers: Array[Marker2D], scenes: Array[PackedScene]) -> void:
	for marker in markers:
		spawn_entity(marker.global_position, scenes[randi_range(0, scenes.size() - 1)])

func spawn_entity(spawn_position: Vector2, scene: PackedScene) -> void:
	var entity = scene.instantiate() as Node2D
	entity.global_position = spawn_position
	add_child(entity)
