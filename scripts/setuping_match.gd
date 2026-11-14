extends Control

var limit = 99

func _ready() -> void:
	$"select Bot".item_count = global.bots.size()
	var count = 0
	for i in global.bots:
		$"select Bot".set_item_text(count,i)
		count += 1


func _on_text_edit_text_changed() -> void:
	if int($TextEdit.text) > limit:
		$TextEdit.text = str(limit)


func _on_start_pressed() -> void:
	global.current_bot = load(global.bots[$"select Bot".get_item_text($"select Bot".selected)]["path"]).new()
	global.current_bot_name = $"select Bot".get_item_text($"select Bot".selected)
	global.match_settings["points_win"] = int($TextEdit.text)
	global.match_settings["pathway_match"] = false
	global.match_settings["powerups"] = $powerups.button_pressed
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	#global.match_start()
