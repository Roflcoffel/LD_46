extends Area2D

var Cooldown = load("res://Scripts/Cooldown.gd")
var rain_spawn_rate = Cooldown.new(0.1)

var max_rain : int = 50
var cur_shot : int = 0

var rain_shots : Array

var center : Vector2
var size : Vector2

#export(PackedScene) var shot_scene : PackedScene
onready var shot_scene : PackedScene = load("res://Bosses/ElectroBall.tscn")

onready var main_scene : Node = get_tree().current_scene
onready var colshape2d = $CollisionShape2D

var velocity : Vector2 = Vector2.DOWN
var shot_inst

func _ready():
	center = colshape2d.position + position
	size = colshape2d.shape.extents

func _physics_process(delta):
	rain_spawn_rate.tick(delta)
	
	if rain_spawn_rate.is_ready():
		shot_inst = shot_scene.instance()
		shot_inst.global_position = random_pos_in_area()
		shot_inst.Angle = velocity
		main_scene.add_child(shot_inst)
		rain_shots.append(shot_inst)

func random_pos_in_area() -> Vector2:
	return Vector2((randi() % int(size.x)) - (size.x/2) + center.x, size.y/2)

