extends KinematicBody2D

export var Health: int = 3 setget set_health
export var Max_Speed: int = 200

var Acceleration: int = 400
var Friction: int = 1000

var velocity : Vector2 = Vector2.ZERO
var input_vector : Vector2

onready var health_indicator = $HealthIndicator

func _ready():
	health_indicator.set_hearts(Health)

func set_health(value : int):
	print("Set Health")
	Health = max(value, 0)
	health_indicator.set_hearts(Health)
	if Health == 0:
		print("Dead")

func _physics_process(delta):
	input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = input_vector * Max_Speed
		#velocity = velocity.move_toward(input_vector * Max_Speed, Acceleration * delta)
	else:
		velocity = Vector2.ZERO 
		#velocity.move_toward(Vector2.ZERO, Friction * delta)
	
	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(_area):
	self.Health -= 1
