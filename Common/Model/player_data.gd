class_name PlayerData
extends RefCounted

var health: int
var fuel: float

@warning_ignore("shadowed_variable")
func _init(health: int, fuel: float) -> void:
	self.health = health
	self.fuel = fuel
