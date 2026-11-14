extends RigidBody2D

@export var gravityScale = 0.116

var active_powerups = {"speed":false}

@export var normal_max_speed:float
@export var speed_max_speed:float

@export_color_no_alpha var normal
@export_color_no_alpha var speed

var max_speed
func _ready() -> void:
	max_speed = normal_max_speed
	$rotation_lock/RichTextLabel.visible = false

func _physics_process(delta: float) -> void:
	limit_speed()
	gravity()
	global.ball_position = position
	$rotation_lock.rotation_degrees = -rotation_degrees

func gravity():
	if position.y < 0:
		gravity_scale = -gravityScale
	else:
		gravity_scale = gravityScale

func limit_speed():
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

func activate_speed():
	$"speed timer".start()
	active_powerups["speed"] = true
	max_speed = speed_max_speed
	modulate = speed

func deactivate_speed():
	$"speed timer".stop()
	active_powerups["speed"] = false
	max_speed = normal_max_speed
	modulate = normal
	

func _on_speed_timer_timeout() -> void:
	deactivate_speed()

func deactivate_all_powerups():
	deactivate_speed()
