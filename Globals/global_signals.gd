class_name GlobalSignals
extends Node

@warning_ignore("unused_signal")
signal player_vertical_acceleration_changed(acceleration_percent: float)

@warning_ignore("unused_signal")
signal player_health_changed(current_health: int)

@warning_ignore("unused_signal")
signal player_destroyed()

@warning_ignore("unused_signal")
signal score_earned(amount: int)
