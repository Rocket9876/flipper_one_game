extends Node

var near = false

var distance = 300

func _physics_process(delta: float) -> void:
	action_logic()

func action_logic():
	if global.bot["position"].distance_to(global.ball_position) < distance and not near:
		global.flipper_top_left.flip()
		global.flipper_top_right.flip()
		near = true
		print(1)
	elif global.bot["position"].distance_to(global.ball_position) > distance:
		print(2)
		if near:
			print(3)
			global.flipper_top_left.flip_down()
			global.flipper_top_right.flip_down()
			near = false
