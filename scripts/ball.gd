extends RigidBody2D

@export var gravityScale = 0.116

func _physics_process(delta: float) -> void:
	gravity()

func gravity():
	if position.y < 0:
		gravity_scale = -gravityScale
	elif position.y > 0:
		gravity_scale = gravityScale
