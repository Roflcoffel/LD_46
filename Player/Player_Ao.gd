extends KinematicBody2D

export var Health: int = 3
export var Max_Speed: int = 200

var Acceleration: int = 400
var Friction: int = 1000

var velocity : Vector2 = Vector2.ZERO
var input_vector : Vector2

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
	Health -= 1

	if Health <= 0:
		print("Game Over")