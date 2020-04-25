extends KinematicBody2D

export var Health : int = 1 setget set_health

export var Acceleration : int = 250
export var Max_Speed : int = 250
export var Friction : int = 1000

var velocity = Vector2.ZERO
var player_direction = Vector2.ZERO

onready var player : Node2D = get_parent().get_node("Player")
onready var DetectGunArea : Area2D = $DetectGunArea

onready var health_indicator = $HealthIndicator

func _ready():
	health_indicator.set_hearts(Health)

func set_health(value : int):
	Health = max(value, 0)
	health_indicator.set_hearts(Health)
	if Health == 0:
		print("Game Over")

func _physics_process(delta):
	player_direction = (player.global_position + Vector2(0,40) - global_position).normalized()
	
	if DetectGunArea.is_in_area():
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
	else:
		velocity = velocity.move_toward(player_direction * Max_Speed, Acceleration * delta)		

	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	self.Health -= 1
