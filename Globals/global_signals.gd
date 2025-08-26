class_name GlobalSignals
extends Node

@warning_ignore("unused_signal")
signal scene_loaded()

@warning_ignore("unused_signal")
signal scene_ready()

@warning_ignore("unused_signal")
signal player_initialized()

@warning_ignore("unused_signal")
signal player_vertical_acceleration_changed(acceleration_percent: float)

@warning_ignore("unused_signal")
signal player_health_changed(current_health: int)

@warning_ignore("unused_signal")
signal player_destroyed()

@warning_ignore("unused_signal")
signal bridge_destroyed()

@warning_ignore("unused_signal")
signal player_fuel_changed(fuel_percent: float)

@warning_ignore("unused_signal")
signal score_earned(amount: int)

@warning_ignore("unused_signal")
signal score_changed(current_score: float)

@warning_ignore("unused_signal")
signal level_pieces_added(level_pieces: Array[LevelPiece])
