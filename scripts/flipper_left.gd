extends Node2D

var state = 0

func flip():
	$AnimationPlayer.play("flip_up")
