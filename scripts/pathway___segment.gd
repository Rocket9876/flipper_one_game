extends Control

var completed = false

@export var stage:int

@export var stage_name:String

@export var Enemie:String

@export var min_points:int

@export var powerups:bool

func _ready() -> void:
	if global.completed_stage >= stage:
		completed = true
	$"STAGE DESCRIPTION".text = stage_name + "\n\nEnemie: " + Enemie + "\n\nThe first player to reach " + str(min_points) + " points wins!" +"\nPowerups: " + str(powerups) + "\nCompleted: " + str(completed)
	if global.completed_stage + 1 >= stage:
		visible = true
	else:
		visible = false
	




func _on_start_pressed() -> void:
	global.match_settings["points_win"] = min_points
	global.match_settings["pathway_match"] = true
	global.match_settings["pathway_stage"] = stage
	global.current_bot_name = Enemie
	global.match_settings["powerups"] = powerups
	global.current_bot = load(global.bots[Enemie]["path"]).new()
	get_tree().change_scene_to_file("res://scenes/world.tscn")
