class_name LevelEntityScrollComponent
extends ScrollComponent

const SCROLL_VELOCITY: Vector2 = Vector2(0.0, 200.0)

var adjusted_scroll_velocity: Vector2

func _ready() -> void:
	super()
	adjusted_scroll_velocity = SCROLL_VELOCITY
	Signals.player_vertical_acceleration_changed.connect(set_adjusted_velocity)

func set_adjusted_velocity(player_acceleration_percent: float) -> void:
	adjusted_scroll_velocity = player_acceleration_percent * SCROLL_VELOCITY

func get_velocity() -> Vector2:
	return adjusted_scroll_velocity
