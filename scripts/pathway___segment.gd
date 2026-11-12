extends Control

var completed = false

@export var stage:int

@export var stage_name:String

@export var Enemie:String

@export var min_points:int

func _ready() -> void:
	$"STAGE DESCRIPTION".text = stage_name + "\n\nEnemie: " + Enemie + "\n\nThe first player to reach " + str(min_points) + " points wins!" + "\n\nCompleted: " + str(completed)




func _on_start_pressed() -> void:
	global.match_settings["points_win"] = min_points
	global.match_settings["pathway_match"] = true
	global.current_bot_name = Enemie
	global.current_bot = load(global.bots[Enemie]["path"]).new()
	get_tree().change_scene_to_file("res://scenes/world.tscn")
