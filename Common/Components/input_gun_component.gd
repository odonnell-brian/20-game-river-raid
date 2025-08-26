class_name InputGunComponent
extends GunComponent

func shoot_triggered() -> bool:
	return Input.is_action_pressed("shoot")
