extends Node

var inside = false

var detection_heigt = 250
var detection_width = 200

var side = "top"

func detect_ball():
	if side == "top":
		if global.bot["position"].x + (detection_width / 2) > global.ball.position.x and global.ball.position.x > global.bot["position"].x + -(detection_width / 2) and -detection_heigt > global.ball.position.y:
			inside = true
		else:
			inside = false
	else:
		if global.bot_2["position"].x + (detection_width / 2) > global.ball.position.x and global.ball.position.x > global.bot_2["position"].x + -(detection_width / 2) and detection_heigt < global.ball.position.y:
			print(123)
			inside = true
		else:
			inside = false

func _physics_process(delta: float) -> void:
	detect_ball()
	flip()

func flip():
	if side == "top":
		if inside:
			global.flipper_top_left.flip()
			global.flipper_top_right.flip()
		else:
			global.flipper_top_left.flip_down()
			global.flipper_top_right.flip_down()
	else:
		if inside:
			global.flipper_bottem_left.flip()
			global.flipper_bottem_right.flip()
		else:
			global.flipper_bottem_left.flip_down()
			global.flipper_bottem_right.flip_down()

func _ready() -> void:
	print(side)
