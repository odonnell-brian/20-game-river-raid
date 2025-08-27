class_name EnemyMoveComponent
extends Area2D

const HORIZONTAL_SPEED: float = 50.0
const MAX_WAIT_SECONDS = 1.0
const MAX_MOVE_TIME = 4.0

@onready var idle_timer = $IdleTimer

var move_right: bool = false
var moving: bool = false

func _ready() -> void:
	area_entered.connect(on_collide)
	idle_timer.timeout.connect(on_timer_timeout)
	on_timer_timeout()

func _physics_process(delta: float) -> void:
	if not moving:
		return

	var direction_int = 1 if move_right else -1
	get_parent().global_position.x += HORIZONTAL_SPEED * delta * direction_int

func on_collide(node: Node2D) -> void:
	if node is PathBlockerComponent:
		move_right = !move_right

func on_timer_timeout() -> void:
	if moving:
		idle_timer.start(randf_range(0.0, MAX_WAIT_SECONDS))
	else:
		idle_timer.start(randf_range(2, MAX_MOVE_TIME))

	moving = !moving
	move_right = false if randi() % 2 == 0 else true
