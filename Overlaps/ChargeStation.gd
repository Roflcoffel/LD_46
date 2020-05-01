extends Node2D

var gun : KinematicBody2D = null

func _on_body_entered(body : Node) -> void:
	self.gun = body
	gun.energy_rate.wait_time = 0.05

func _on_body_exited(_body : Node) -> void:
	gun.energy_rate.wait_time = 0.1
	self.gun = null
