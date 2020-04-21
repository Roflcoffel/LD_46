extends Area2D

var GunArea : Area2D = null

func is_in_gun_area() -> bool:
	return GunArea != null

func _on_DetectGunArea_area_entered(area : Area2D):
	GunArea = area

func _on_DetectGunArea_area_exited(_area : Area2D):
	GunArea = null
