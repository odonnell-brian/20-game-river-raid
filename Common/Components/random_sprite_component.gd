class_name RandomSpriteComponent
extends Node

func enable_random_sprite(node: Node2D) -> void:
	var sprites: Array[Sprite2D] = []

	for child in node.get_children():
		if child is Sprite2D:
			sprites.append(child)
			child.visible = false

	sprites[randi_range(0, sprites.size() - 1)].visible = true
