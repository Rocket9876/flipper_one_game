extends Node

var y_distance = -120

@onready var flipper = global.flipper_top_right

var turn = 0

var left = 0

var right = 0




func _physics_process(delta: float) -> void:
	if global.current_bot == self:
		global.bot["name"] = "ALEX"
	if detect_flipper() == "left":
		flipper = global.flipper_top_left
	elif detect_flipper() == "right":
		flipper = global.flipper_top_right
	if detect_flipper():
			flipper.flip()

	
	
	if not detect_flipper():
		down(global.flipper_top_left)
		down(global.flipper_top_right)


func detect_flipper():
	if global.ball_position.y < global.bot["position"].y - y_distance:
		if global.ball_position.x < 0:
			return "left"
		elif global.ball_position.x > 0:
			return "right"
		else:
			return null

func down(flipper):
	if flipper.state == 1:
		flipper.flip_down()
