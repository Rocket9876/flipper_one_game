extends Control

func _ready() -> void:
	if global.score["bottem"] > global.score["top"]:
		$winner.text = "YOU WON!"
	else:
		$winner.text = global.current_bot_name + " WON!"
	global.score["bottem"] = 0
	global.score["top"] = 0
	if global.match_settings["pathway_match"]:
		$back.text = "BACK TO PATHWAY"
		if global.completed_stage < global.match_settings["pathway_stage"] and global.score["top"] > global.score["bottem"]:
			global.completed_stage = global.match_settings["pathway_stage"]


func _on_back_pressed() -> void:
	if global.match_settings["pathway_match"]:
		get_tree().change_scene_to_file("res://scenes/pathway.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/start___page.tscn")
