extends Node

var completed_stage = 0

var save_file_path = "user://pathway.save"

var bot_active = false

var ball_position

var last_winner

var in_match = false

var bots = {}

var score = {"bottem":0,"top":0}

var bot_path = "res://scripts/bots/"

var bot = {"position":Vector2(),"name":""}

@onready var world = get_node("/root/world")

@onready var andy = preload("res://scripts/bots/andy_bot.gd").new()

@onready var ball = get_node("/root/world/ball")

@onready var alex = preload("res://scripts/bots/alex_bot.gd").new()

@onready var speed_powerup = preload("res://scenes/power_up___speed.tscn")
@onready var jump_powerup = preload("res://scenes/power_up_jump_boost.tscn")

var current_bot

var current_bot_name

@onready var flipper_top_left
@onready var flipper_top_right 

var match_settings = {"points_win":5,"pathway_match":false,"pathway_stage":0,"powerups":false,"bot":true}

func _ready() -> void:
	if FileAccess.file_exists(save_file_path):
		var file = load_data(save_file_path)
		completed_stage = file.get_var()
		file.close()
	for i in DirAccess.get_files_at(bot_path):
		i = i.trim_suffix(".remap")
		if not i.ends_with(".uid"):
			
			bots.merge({i.get_slice("_",0):{"path":bot_path + i}})

func _physics_process(delta: float) -> void:
	if in_match:
		ball._physics_process(delta)
		world._physics_process(delta)
		if global.match_settings["bot"]:
			current_bot._physics_process(delta)
		world.top_score.text = str(score["top"])
		world.bottem_score.text = str(score["bottem"])

func match_start():
	flipper_top_left = get_node("/root/world/kicker/flipper_top_left")
	flipper_top_right = get_node("/root/world/kicker/flipper_top_right")
	world = get_node("/root/world")
	ball = get_node("/root/world/ball")

func pythagorean_theorem(x,y):
	return sqrt((abs(x)*abs(x))+(abs(y)*abs(y)))

func load_data(path):
	return FileAccess.open(path,FileAccess.READ)

func save_data(path,data):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_var(data)
	file.close()
