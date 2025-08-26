extends Node2D

@export var sprite_picker: RandomSpriteComponent
@export var z_index_picker: RandomZIndexComponent

func _ready() -> void:
	sprite_picker.enable_random_sprite(self)
	z_index_picker.on_init()
