extends RigidBody2D

@export var gravityScale = 0.116

func _ready() -> void:
	$rotation_lock/RichTextLabel.visible = false

func _physics_process(delta: float) -> void:
	gravity()
	global.ball_position = position
	$rotation_lock.rotation_degrees = -rotation_degrees

func gravity():
	if position.y < 0:
		gravity_scale = -gravityScale
	else:
		gravity_scale = gravityScale
