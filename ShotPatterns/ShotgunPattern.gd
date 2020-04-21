extends Node

class_name ShotgunPattern

var line_pattern_file = load("res://ShotPatterns/LinePattern.gd")
var Cooldown = load("res://Scripts/Cooldown.gd")
var shotgun_cooldown

var line_pattern : LinePattern
var angle        : int          #the direction the shotgun is pointing
var spread       : Array        #spread is based on the "angles" provided
var patterns     : Array
var num_shots    : int			#number of line pattern shots
var cur_shot     : int

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _init(line_pattern : LinePattern, num_shots : int, angle : int):
	self.line_pattern = line_pattern
	self.num_shots = num_shots
	self.angle = angle
	shotgun_cooldown = Cooldown.new(0.3)	
	self.spread = generate_spread_angles()
	
func shoot(delta: float):
	shotgun_cooldown.tick(delta)
		
	if cur_shot < num_shots and shotgun_cooldown.is_ready():
		cur_shot += 1
		patterns.append(
			line_pattern_file.new(line_pattern.shot_path, line_pattern.main_scene, line_pattern.num_shots, line_pattern.position)
		)

	for i in patterns.size():
		patterns[i].shoot(angle_to_vector(spread[i]), delta)

func generate_spread_angles() -> Array:
	var spread_angles : Array = []
	for i in num_shots:
		spread_angles.append(rng.randi_range(angle-10, angle+10))
	return spread_angles

func angle_to_vector(angle : int) -> Vector2:
	return Vector2(cos(angle*PI/180), sin(angle*PI/180))
	
