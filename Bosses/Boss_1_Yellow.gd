extends KinematicBody2D

#Look into more signaling!

var Cooldown = load("res://Scripts/Cooldown.gd")
var shotgun_cooldown = Cooldown.new(1)

onready var line_pattern_file = load("res://ShotPatterns/LinePattern.gd")
onready var shotgun_pattern_file = load("res://ShotPatterns/ShotgunPattern.gd")

onready var main = get_tree().current_scene

var shotgun_pattern : Array

var cur_shot : int = 0

export var shotgun_angles     : Array = [140, 60, 100] 
export var max_line_patterns  : int = 3
export var max_basic_shots    : int = 2

onready var max_shotgun_bursts : int = shotgun_angles.size()

var velocity : Vector2 = Vector2.DOWN
var max_speed : int = 100
var acceleration : int = 100
var friction : int = 600

var waypoints : Array

onready var waypoint_1 : Node2D = get_parent().get_node("Waypoint")
onready var waypoint_2 : Node2D = get_parent().get_node("Waypoint2")
onready var waypoint_3 : Node2D = get_parent().get_node("Waypoint3")

onready var DetectWaypointArea : Area2D = $DetectWaypoint
onready var timer : Timer = $Timer

var go_to_waypoint : bool = false
var cur_waypoint : int = -1
var max_waypoint : int 

func _ready():
	timer.start(4)
	waypoints = [waypoint_1, waypoint_2, waypoint_3]
	max_waypoint = waypoints.size()

func _physics_process(delta):
	shotgun_blast(delta)
	
	if go_to_waypoint == true:
		move(delta)

func shotgun_blast(delta):
	shotgun_cooldown.tick(delta)

	if cur_shot < max_shotgun_bursts and shotgun_cooldown.is_ready():
		var line_inst = line_pattern_file.new("res://Bosses/ElectroBall.tscn", main, max_basic_shots, global_position)
		var shotgun_inst = shotgun_pattern_file.new(line_inst, max_line_patterns, shotgun_angles[cur_shot])
		shotgun_pattern.append(shotgun_inst)
		cur_shot += 1

	for i in shotgun_pattern.size():
		shotgun_pattern[i].shoot(delta)
	
func move(delta):
	var waypoint_direction = (waypoints[cur_waypoint].global_position - global_position).normalized()
	
	if DetectWaypointArea.is_in_area() and DetectWaypointArea.area.id == cur_waypoint:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
		if velocity == Vector2.ZERO:
			reset_variables()
	else:
		velocity = velocity.move_toward(waypoint_direction * max_speed, acceleration * delta)	

	velocity = move_and_slide(velocity)


func _on_Timeout():
	go_to_waypoint = true
	cur_waypoint += 1

func reset_variables():
	go_to_waypoint = false
	shotgun_pattern = []
	cur_shot = 0
	timer.start(4)
	if cur_waypoint == max_waypoint-1:
		cur_waypoint = -1

