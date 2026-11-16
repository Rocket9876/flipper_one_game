@tool
extends Node2D

@export var playable:bool

var state = 0

@export var left = false

func _ready() -> void:
		if left:
			$flipper.rotation_degrees = 0
		else:
			$flipper.rotation_degrees = 180

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		if left:
			#$flipper.rotation_degrees = 0
			pass
		else:
			#$flipper.rotation_degrees = 180
			pass


func flip(force = false):
	if state == 0 or force:
		if left:
			$AnimationPlayer.play("flip left")
		else:
			$AnimationPlayer.play("flip")
		

func flip_down(force = false):
	if state == 1 or force:
		if left:
			$AnimationPlayer.play("flip down left")
		else:
			$AnimationPlayer.play("flip down")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "flip left" or anim_name == "flip":
		state = 1
	else:
		state = 0
