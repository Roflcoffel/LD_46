extends Node2D

var gun : KinematicBody2D = null

func _on_body_entered(body : Node) -> void:
	self.gun = body
	gun.energy_rate.paused = true

func _on_body_exited(_body : Node) -> void:	
	gun.energy_rate.paused = false
	self.gun = null
