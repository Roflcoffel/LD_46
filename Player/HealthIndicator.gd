extends Node2D

onready var heart : PackedScene = load("res://Player/Heart.tscn")

var heart_width : float = 8 # 16x16 Picture, Scaled to 0.5
var offset : float = 4

func set_hearts(num : int) -> void:
	for child in self.get_children():
		child.queue_free()

	for i in num:
		var heart_inst = heart.instance()
		heart_inst.position.x = (heart_width * i + offset+2) - (heart_width * num + offset) / 2   
		self.add_child(heart_inst)

		