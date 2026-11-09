extends Node

var bot_active = false

var ball_position

var bot = {"position":Vector2()}

@onready var world = get_node("/root/world")

@onready var andy = preload("res://scripts/andy_bot.gd").new()

@onready var ball = get_node("/root/world/ball")

@onready var flipper_top_left = get_node("/root/world/kicker/flipper_top_left")
@onready var flipper_top_right = get_node("/root/world/kicker/flipper_top_right")
func _physics_process(delta: float) -> void:
	ball._physics_process(delta)
	world._physics_process(delta)
	andy._physics_process(delta)
