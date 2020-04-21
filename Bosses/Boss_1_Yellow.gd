extends KinematicBody2D

var Cooldown = load("res://Scripts/Cooldown.gd")
var shotgun_cooldown = Cooldown.new(1)

onready var line_pattern_file = load("res://ShotPatterns/LinePattern.gd")
onready var shotgun_pattern_file = load("res://ShotPatterns/ShotgunPattern.gd")

onready var main = get_tree().current_scene

var shotgun_pattern : Array
var shotgun_angles  : Array = [140, 60, 100]

var cur_shot : int = 0
var max_shot : int = 3

#Point on a circle, x = rsin(angle) y = rcos(angle)

func _physics_process(delta):
	shotgun_cooldown.tick(delta)
	
	if cur_shot < max_shot and shotgun_cooldown.is_ready():
		var line_inst = line_pattern_file.new("res://Bosses/ElectroBall.tscn", main, 5, global_position)
		var shotgun_inst = shotgun_pattern_file.new(line_inst, 3, shotgun_angles[cur_shot])
		shotgun_pattern.append(shotgun_inst)
		cur_shot += 1

	for i in shotgun_pattern.size():
		shotgun_pattern[i].shoot(delta)
