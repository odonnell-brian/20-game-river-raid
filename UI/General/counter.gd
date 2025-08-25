class_name Counter
extends Control

var images: Array[TextureRect]

func _ready() -> void:
	for child in get_children():
		if child is TextureRect:
			images.append(child)

func update_value(val: int) -> void:
	for i in images.size():
		images[i].visible = (val == i)
