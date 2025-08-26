class_name LevelPiece
extends Node2D

@export var stitch_point_top: Marker2D
@export var stitch_point_bottom: Marker2D
@export var connections: Array[Enums.LevelPieces]

func get_connecting_piece() -> Enums.LevelPieces:
	var scene_enum: Enums.LevelPieces = connections[randi_range(0, connections.size() - 1)]
	print("Next piece %d" % scene_enum)

	return scene_enum
