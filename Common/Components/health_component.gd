class_name HealthComponent
extends Area2D

signal health_changed(current_health: int)
signal health_depleted()

@export var max_health: int = 1
@export var destroy_on_deplete: bool = true
@export var destroy_fx: PackedScene

var current_health: int

func _ready() -> void:
	current_health = max_health
	area_entered.connect(try_damage)

func try_damage(node: Node2D) -> void:
	if not node is DamageComponent:
		return

	take_damage((node as DamageComponent).damage_amount)

func take_damage(amount: int) -> void:
	current_health = maxi(current_health - amount, 0)
	health_changed.emit(current_health)

	if current_health == 0:
		health_depleted.emit()
		try_destroy()

func try_destroy() -> void:
	if not destroy_on_deplete:
		return

	if destroy_fx:
		var fx: Node2D = destroy_fx.instantiate() as Node2D
		fx.global_position = global_position
		get_tree().current_scene.add_child(fx)

	get_parent().queue_free()
