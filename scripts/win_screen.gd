extends Control

func _ready() -> void:
	if global.score["bottem"] > global.score["top"]:
		if global.match_settings["bot"] and not global.match_settings["bot vs bot"]:
			$winner.text = global.current_bot_name + " WON!"
		elif global.match_settings["bot vs bot"]:
			$winner.text = global.bot["name"] + " WON!"
		else:
			$winner.text = "BOTTEM WON!"
	else:
		if global.match_settings["bot"] and not global.match_settings["bot vs bot"]:
			$winner.text = global.current_bot_name + " WON!"
		elif global.match_settings["bot vs bot"]:
			$winner.text = global.bot_2["name"] + " WON!"
		else:
			$winner.text = "TOP WON!"

	if global.match_settings["pathway_match"]:
		$back.text = "BACK TO PATHWAY"
		if global.completed_stage < global.match_settings["pathway_stage"] and global.score["top"] < global.score["bottem"]:
			global.completed_stage = global.match_settings["pathway_stage"]
			global.save_data(global.save_file_path,global.completed_stage)
	global.score["bottem"] = 0
	global.score["top"] = 0



func _on_back_pressed() -> void:
	if global.match_settings["pathway_match"]:
		get_tree().change_scene_to_file("res://scenes/pathway.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/start___page.tscn")
