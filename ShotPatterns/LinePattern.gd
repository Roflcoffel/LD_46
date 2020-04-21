extends Node

class_name LinePattern

var Cooldown = load("res://Scripts/Cooldown.gd")
var shoot_cooldown

var Shot        : PackedScene
var shot_path   : String
var num_shots   : int
var position    : Vector2
var basic_shots : Array
var main_scene  : Node
var cur_shots   : int

func _init(shot_path : String, main_scene : Node, num_shots : int, position : Vector2):
	self.shot_path = shot_path
	self.main_scene = main_scene
	self.num_shots = num_shots
	self.position = position
	shoot_cooldown = Cooldown.new(0.1)
	Shot = load(self.shot_path)

func shoot(velocity : Vector2, delta : float):
	shoot_cooldown.tick(delta)

	if cur_shots < num_shots and shoot_cooldown.is_ready():
		cur_shots += 1
		var inst_shot = Shot.instance()
		inst_shot.global_position = position
		main_scene.add_child(inst_shot)
		basic_shots.append(inst_shot)

	for shot in basic_shots:
		if is_instance_valid(shot):
			shot.shoot(velocity, delta)
	


