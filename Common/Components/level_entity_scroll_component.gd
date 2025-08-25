class_name LevelEntityScrollComponent
extends ScrollComponent

var adjusted_scroll_velocity: Vector2

func _ready() -> void:
	super()
	adjusted_scroll_velocity = scroll_velocity
	Signals.player_vertical_acceleration_changed.connect(set_adjusted_velocity)

func set_adjusted_velocity(player_acceleration_percent: float) -> void:
	adjusted_scroll_velocity = player_acceleration_percent * scroll_velocity

func get_velocity() -> Vector2:
	return adjusted_scroll_velocity
