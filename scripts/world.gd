extends Node2D

var mouse_quadrant

var state  = 0

var focused_quadrant



func flip(path):
	path.flip()

@export var ball_spawn_range:float

@onready var top_score = $top_score
@onready var bottem_score = $bottem_score

func _physics_process(delta: float) -> void:
	#flip($"kicker/flipper_bottem_left")
	#flip($"kicker/flipper_bottem_right")
	mouse_quadrant = Vector2(get_number_dir(get_global_mouse_position().x),get_number_dir(get_global_mouse_position().y))
	#print(get_current_flipper())
	#print(mouse_quadrant)
	global.bot["position"] = $bot.position
	detect_flip_action()

func _ready():
	small_restart()

func get_number_dir(number):
	if number > 0:
		return 1
	else:
		return 0

func fliping():
	pass


func get_current_flipper(quadrant:Vector2 = mouse_quadrant):
	return get_node("kicker/flipper_" + ["top","bottem"][quadrant.y] + "_" + ["left","right"][quadrant.x])

func detect_flip_action():
	if Input.is_action_just_pressed("click"):
		if get_current_flipper().playable:
			state = 1
			focused_quadrant = mouse_quadrant
			get_current_flipper().flip()
	elif Input.is_action_just_released("click"):
		if get_current_flipper(focused_quadrant).playable and state == 1:
			get_current_flipper(focused_quadrant).flip_down()
			state = 0

func bot_flipper_interface(selection):
	if selection == 1:
		$kicker/flipper_top_left.flip()
	else:
		$kicker/flipper_top_right.flip()
	



func _on_bottem_zone_body_entered(body) -> void:
	if body.is_in_group("ball"):
		win("bottem")

func _on_top_zone_body_entered(body) -> void:
	if body.is_in_group("ball"):
		win("top")

func win(player, points = 1):
	global.score[player] += points
	$AnimationPlayer.play("flash " + player)
	$flash.visible = true
	global.ball.visible = false
	global.ball.sleeping = true
	$"win cooldown".start()

func small_restart():
	$flash.visible = false
	global.ball.position = Vector2(randf_range(-ball_spawn_range,ball_spawn_range),randf_range(-ball_spawn_range,ball_spawn_range))
	global.ball.visible = true
	global.ball.sleeping = false
	global.ball.move_and_collide(Vector2.ZERO)

func _on_win_cooldown_timeout() -> void:
	small_restart()
