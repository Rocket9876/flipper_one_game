extends Node2D

var mouse_quadrant

var state  = 0

var focused_quadrant

var keyboard_control = false

@export var ball_normal_time:float
@export var ball_danger_time:float
var ball_half

var ball_danger = false

func flip(path):
	path.flip()

@export var ball_spawn_range:float

@onready var top_score = $top_score
@onready var bottem_score = $bottem_score

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("<") or Input.is_action_pressed(">"):
		keyboard_control = true
	if Input.is_action_pressed("click"):
		keyboard_control = false
	$name_top.text = global.bot["name"]
	mouse_quadrant = Vector2(get_number_dir(get_global_mouse_position().x),get_number_dir(get_global_mouse_position().y))
	global.bot["position"] = $bot.position
	
	if keyboard_control:
		detect_flip_action_keyboard()
	else:
		detect_flip_action()
	ball_counter()
	for i in global.score:
		if global.score[i] >= global.match_settings["points_win"]:
			global.last_winner = i
	
	if ball_danger:
		global.ball.get_node("rotation_lock/RichTextLabel").text = str($Ball_Timer.time_left)

func _ready():
	global.in_match = true
	small_restart()
	$name_top.text = global.bot["name"]

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
		win("top")

func _on_top_zone_body_entered(body) -> void:
	if body.is_in_group("ball"):
		win("bottem")

func win(player, points = 1):
	global.ball.position = Vector2(0,0)
	global.ball.move_and_collide(Vector2.ZERO)
	global.score[player] += points
	if player == "top":
		$AnimationPlayer.play("flash " + "bottem")
	else:
		$AnimationPlayer.play("flash " + "top")
	$flash.visible = true
	global.ball.visible = false
	global.ball.sleeping = true
	$"win cooldown".start()

func small_restart():
	global.ball.get_node("rotation_lock/RichTextLabel").visible = true
	$Ball_Timer.start()
	$flash.visible = false
	global.ball.position = Vector2(randf_range(-ball_spawn_range,ball_spawn_range),randf_range(-ball_spawn_range,ball_spawn_range))
	global.ball.visible = true
	global.ball.sleeping = false
	global.ball.move_and_collide(Vector2.ZERO)

func _on_win_cooldown_timeout() -> void:
	small_restart()


func detect_flip_action_keyboard():
	if Input.is_action_pressed(">") and get_node("kicker/flipper_bottem_right").state == 0:
		get_node("kicker/flipper_bottem_right").flip() 
	elif get_node("kicker/flipper_bottem_right").state == 1 and not Input.is_action_pressed(">"):
		get_node("kicker/flipper_bottem_right").flip_down()
	if Input.is_action_pressed("<") and get_node("kicker/flipper_bottem_left").state == 0:
		get_node("kicker/flipper_bottem_left").flip()
	elif get_node("kicker/flipper_bottem_left").state == 1 and not Input.is_action_pressed("<"):
		get_node("kicker/flipper_bottem_left").flip_down()

func ball_counter():
	if global.ball_position.y > 0 and ball_half != "bottem":
		ball_danger = false
		$Ball_Timer.start(ball_normal_time)
		ball_half = "bottem"
		global.ball.get_node("rotation_lock/RichTextLabel").visible = false
	if global.ball_position.y < 0 and ball_half != "top":
		ball_danger = false
		$Ball_Timer.start(ball_normal_time)
		ball_half = "top"
		global.ball.get_node("rotation_lock/RichTextLabel").visible = false


func _on_ball_timer_timeout() -> void:
	if not ball_danger:
		ball_danger = true
		global.ball.get_node("rotation_lock/RichTextLabel").visible = true
		$Ball_Timer.stop()
		$Ball_Timer.start(ball_danger_time)
	elif ball_danger:
		$Ball_Timer.stop()
		if ball_half == "top":
			win("bottem")
		else:
			win("top")
	
