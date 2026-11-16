extends Node

var near = false

var distance = 180

var side = "top"

func _physics_process(delta: float) -> void:
	if global.match_settings["bot vs bot"]:
		if global.current_bots[0] == self:
			global.bot["name"] = "ANDY"
			action_logic()
		elif global.current_bots[1] == self:
			global.bot_2["name"] = "ANDY"
			action_logic(global.bot_2.position)
		
	else:
		if global.current_bot == self:
			global.bot["name"] = "ANDY"
		action_logic()

func action_logic(position = global.bot["position"]):
	if position.distance_to(global.ball_position) < distance and not near:
		if side == "bottem":
			global.flipper_top_left.flip()
			global.flipper_top_right.flip()
		else:
			global.flipper_bottem_left.flip()
			global.flipper_bottem_right.flip()
		near = true
	elif position.distance_to(global.ball_position) > distance:
		if near:
			if side == "bottem":
				global.flipper_top_left.flip_down()
				global.flipper_top_right.flip_down()
			else:
				global.flipper_bottem_left.flip_down()
				global.flipper_bottem_right.flip_down()
			near = false
