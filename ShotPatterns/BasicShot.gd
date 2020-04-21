extends KinematicBody2D

var Acceleration : int = 800
var Max_Speed : int = 200

var Velocity : Vector2 = Vector2.ZERO

func shoot(angle : Vector2, delta : float) -> void:
	Velocity = Velocity.move_toward(angle * Max_Speed, Acceleration * delta)

func _physics_process(delta):
	Velocity = move_and_slide(Velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Hitbox_area_entered(_area):
	queue_free()