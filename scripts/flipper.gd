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
		state = 1
		if left:
			$AnimationPlayer.play("flip left")
		else:
			$AnimationPlayer.play("flip")
		

func flip_down(force = false):
	if state == 1 or force:
		state = 0
		if left:
			$AnimationPlayer.play("flip down left")
		else:
			$AnimationPlayer.play("flip down")
