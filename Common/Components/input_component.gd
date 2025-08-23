class_name InputComponent
extends Node

enum InputState {MOVE_LEFT, MOVE_RIGHT, ACCELERATE, DECELERATE, NONE}

var current_state: InputState = InputState.NONE
var previous_state: InputState = InputState.NONE

func update_state() -> void:
	previous_state = current_state
	if not Input.is_anything_pressed():
		current_state = InputState.NONE
	elif Input.is_action_just_pressed("move_left"):
		current_state = InputState.MOVE_LEFT
	elif Input.is_action_just_pressed("move_right"):
		current_state = InputState.MOVE_RIGHT

func state_just_changed() -> bool:
	return previous_state != current_state
