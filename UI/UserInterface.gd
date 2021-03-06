extends Control

onready var scene_tree = get_tree()

onready var pause_overlay : ColorRect = $PauseOverlay
onready var energy_ui : TextureProgress = $EnergyBar

var paused : bool = false setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = !paused
		scene_tree.set_input_as_handled()

func set_paused(value : bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _on_Gun_energy_changed(value : int) -> void:
	energy_ui.value = value

