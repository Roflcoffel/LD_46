
var time: float = 0.0
var max_time: float = 0.0

func _init(max_time: float):
	self.max_time = max_time
	self.time = 0

func tick(delta: float):
	time = max(time - delta, 0)

func is_ready():
	if time > 0:
		return false
	time = max_time
	return true
