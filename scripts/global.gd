extends Node

var bot_active = false

var ball_position

var score = {"bottem":0,"top":0}

var bot = {"position":Vector2()}

@onready var world = get_node("/root/world")

@onready var andy = preload("res://scripts/bots/andy_bot.gd").new()

@onready var ball = get_node("/root/world/ball")

@onready var alex = preload("res://scripts/bots/alex_bot.gd").new()

var current_bot

@onready var flipper_top_left = get_node("/root/world/kicker/flipper_top_left")
@onready var flipper_top_right = get_node("/root/world/kicker/flipper_top_right")

func _ready() -> void:
	current_bot = alex

func _physics_process(delta: float) -> void:
	if get_tree().current_scene == world:
		ball._physics_process(delta)
		world._physics_process(delta)
		current_bot._physics_process(delta)
		world.top_score.text = str(score["top"])
		world.bottem_score.text = str(score["bottem"])
