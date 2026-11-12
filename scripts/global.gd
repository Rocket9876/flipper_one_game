extends Node

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

var current_bot

var current_bot_name

@onready var flipper_top_left
@onready var flipper_top_right 

var match_settings = {"points_win":5,"pathway_match":false}

func _ready() -> void:
	for i in DirAccess.get_files_at(bot_path):
		i = i.trim_suffix(".remap")
		if not i.ends_with(".uid"):
			
			bots.merge({i.get_slice("_",0):{"path":bot_path + i}})

func _physics_process(delta: float) -> void:
	if in_match:
		ball._physics_process(delta)
		world._physics_process(delta)
		current_bot._physics_process(delta)
		world.top_score.text = str(score["top"])
		world.bottem_score.text = str(score["bottem"])

func match_start():
	flipper_top_left = get_node("/root/world/kicker/flipper_top_left")
	flipper_top_right = get_node("/root/world/kicker/flipper_top_right")
	world = get_node("/root/world")
	ball = get_node("/root/world/ball")
