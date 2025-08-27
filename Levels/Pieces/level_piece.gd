class_name LevelPiece
extends Node2D

signal level_piece_entered_screen(piece: LevelPiece)
signal level_piece_exited_screen(piece: LevelPiece)

@export var stitch_point_top: Marker2D
@export var stitch_point_bottom: Marker2D
@export var connections: Array[Enums.LevelPieces]
@export var enemy_spawns: Array[Marker2D] = []
@export var fuel_spawns: Array[Marker2D] = []
@export var bridge_spawn: Marker2D
@export var visibility_notifier: VisibleOnScreenNotifier2D

var on_screen: bool = false
var is_bridge_piece: bool = false

func _ready() -> void:
	visibility_notifier.screen_entered.connect(on_enter_screen)
	visibility_notifier.screen_exited.connect(on_exit_screen)

func get_connecting_piece() -> Enums.LevelPieces:
	var scene_enum: Enums.LevelPieces = connections[randi_range(0, connections.size() - 1)]
	print("Next piece %d" % scene_enum)

	return scene_enum

func on_exit_screen() -> void:
	on_screen = false
	level_piece_exited_screen.emit(self)

func on_enter_screen() -> void:
	on_screen = true
	level_piece_entered_screen.emit(self)
