class_name LevelManager
extends Node2D

const MAX_PIECES: int = 5

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

func _ready() -> void:
	mid_x = get_viewport().size.x / 2.0
	level_pieces.append(starting_piece)
	starting_piece.level_piece_exited_screen.connect(on_piece_exited_screen)
	Signals.scene_ready.connect(generate_level_segment.bind(MAX_PIECES - 1))

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

	var pos_y: float = prev_piece.stitch_point_top.global_position.y - level_piece.stitch_point_bottom.position.y
	level_piece.global_position = Vector2(mid_x, pos_y)
	add_child(level_piece)

	return level_piece

func on_piece_exited_screen(_piece: LevelPiece) -> void:
	pieces_exited = (pieces_exited + 1) % MAX_PIECES

	if pieces_exited == 2:
		generate_level_segment(MAX_PIECES)
		clean_up_old_pieces()

func clean_up_old_pieces() -> void:
	if level_pieces.size() > MAX_PIECES * 2:
		var pieces_to_free: Array[LevelPiece] = level_pieces.slice(0, MAX_PIECES)
		level_pieces = level_pieces.slice(MAX_PIECES)
		for piece in pieces_to_free:
			piece.queue_free()
