class_name LevelManager
extends Node2D

const MAX_PIECES_PER_SEGMENT: int = 5
const MAX_PIECES: int = MAX_PIECES_PER_SEGMENT * 2
const Y_SPAWN_POSITION: float = 600.0

# Not super fond of this, but I was having issues directly defining the PackedScene as an export
# var on the LevelPiece script. Tried also moving this map into an autoload script, but there appeared
# to be errors around script loading order - implication was that the preloads were happening before the
# level_piece.gd script was loaded.
const LEVEL_PIECE_TO_SCENE: Dictionary[Enums.LevelPieces, PackedScene] = {
	Enums.LevelPieces.LEVEL_STARTING: preload("res://Levels/Pieces/level_starting.tscn"),
	Enums.LevelPieces.WIDE_TO_NARROW: preload("res://Levels/Pieces/wide_to_narrow.tscn"),
	Enums.LevelPieces.NARROW_TO_WIDE: preload("res://Levels/Pieces/narrow_to_wide.tscn"),
	Enums.LevelPieces.NARROW_MID: preload("res://Levels/Pieces/narrow_mid2.tscn"),
}

@export var starting_piece: LevelPiece

var level_pieces: Array[LevelPiece]
var mid_x: float
var pieces_exited: int = 0
var resetting: bool = false
var checkpoint_index: int = 0

func _init() -> void:
	GlobalData.level_manager = self

func _ready() -> void:
	mid_x = get_viewport().size.x / 2.0
	level_pieces.append(starting_piece)
	starting_piece.level_piece_exited_screen.connect(on_piece_exited_screen)
	Signals.scene_ready.connect(generate_level_segment.bind(MAX_PIECES_PER_SEGMENT - 1))
	Signals.reset_level_segment.connect(reset_segment_positions)
	Signals.bridge_destroyed.connect(on_bridge_destroyed)

func generate_level_segment(num_pieces: int) -> void:
	print("\nGenerating new level segment")

	var prev_piece: LevelPiece = level_pieces[level_pieces.size() - 1]
	var new_pieces: Array[LevelPiece] = []
	for i in range(0, num_pieces):
		var next_piece_enum: Enums.LevelPieces = prev_piece.get_connecting_piece()

		var next_level_piece = position_and_add_piece(prev_piece, LEVEL_PIECE_TO_SCENE.get(next_piece_enum))
		next_level_piece.level_piece_exited_screen.connect(on_piece_exited_screen)
		new_pieces.append(next_level_piece)
		level_pieces.append(next_level_piece)
		prev_piece = next_level_piece

	Signals.level_pieces_added.emit(new_pieces)

func position_and_add_piece(prev_piece: LevelPiece, next_piece: PackedScene) -> LevelPiece:
	var level_piece: LevelPiece = next_piece.instantiate() as LevelPiece
	position_piece_relative_to_previous(prev_piece, level_piece)
	add_child(level_piece)

	return level_piece

func position_piece_relative_to_previous(prev_piece: LevelPiece, next_piece: LevelPiece) -> void:
	var pos_y: float = prev_piece.stitch_point_top.global_position.y - next_piece.stitch_point_bottom.position.y
	next_piece.global_position = Vector2(mid_x, pos_y)

func on_piece_exited_screen(_piece: LevelPiece) -> void:
	if resetting:
		return

	pieces_exited = (pieces_exited + 1) % MAX_PIECES_PER_SEGMENT

	if pieces_exited == 2 and level_pieces.size() <= MAX_PIECES:
		generate_level_segment(MAX_PIECES_PER_SEGMENT)

	clean_up_old_pieces()

func clean_up_old_pieces() -> void:
	if level_pieces.size() > MAX_PIECES:
		var pieces_to_free: Array[LevelPiece] = level_pieces.slice(0, MAX_PIECES_PER_SEGMENT)
		level_pieces = level_pieces.slice(MAX_PIECES_PER_SEGMENT)
		for piece in pieces_to_free:
			piece.queue_free()

func reset_segment_positions() -> void:
	resetting = true
	print("resetting level")
	var prev_index = max(0, checkpoint_index)
	var prev_piece = level_pieces[prev_index]
	prev_piece.global_position = Vector2(mid_x, Y_SPAWN_POSITION)
	for piece in level_pieces.slice(prev_index + 1):
		position_piece_relative_to_previous(prev_piece, piece)
		prev_piece = piece

	pieces_exited = 0
	Signals.level_pieces_added.emit(level_pieces)
	resetting = false

func on_bridge_destroyed() -> void:
	var first_bridge_index: int = -1
	for i in level_pieces.size():
		if level_pieces[i].is_bridge_piece:
			first_bridge_index = i
			break

	checkpoint_index = first_bridge_index + 1
