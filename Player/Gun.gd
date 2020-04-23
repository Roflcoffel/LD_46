extends KinematicBody2D

export var Acceleration : int = 250
export var Max_Speed : int = 250
export var Friction : int = 1000

var velocity = Vector2.ZERO
var player_direction = Vector2.ZERO

onready var player : Node2D = get_parent().get_node("Player")
onready var DetectGunArea : Area2D = $DetectGunArea

func _physics_process(delta):
	player_direction = (player.global_position + Vector2(0,40) - global_position).normalized()
	
	if DetectGunArea.is_in_area():
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
	else:
		velocity = velocity.move_toward(player_direction * Max_Speed, Acceleration * delta)		

	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	print("Game Over")
