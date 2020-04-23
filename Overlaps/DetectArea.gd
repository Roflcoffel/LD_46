extends Area2D

var area : Area2D = null

func is_in_area() -> bool:
	return self.area != null

func _on_DetectArea_area_entered(area : Area2D):
	self.area = area

func _on_DetectArea_area_exited(_area : Area2D):
	self.area = null
