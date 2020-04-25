extends KinematicBody2D

var Acceleration : int = 800
var Max_Speed : int = 200

var Velocity : Vector2 = Vector2.ZERO
var Angle : Vector2 = Vector2.ZERO

func _physics_process(delta):
	Velocity = Velocity.move_toward(Angle * Max_Speed, Acceleration * delta)
	Velocity = move_and_slide(Velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Hitbox_area_entered(_area):
	queue_free()