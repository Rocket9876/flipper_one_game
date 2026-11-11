extends Control

var limit = 99

func _ready() -> void:
	$"select Bot".item_count = global.bots.size()
	var count = 0
	for i in global.bots:
		print(i)
		$"select Bot".set_item_text(count,i)
		count += 1


func _on_text_edit_text_changed() -> void:
	if int($TextEdit.text) > limit:
		$TextEdit.text = str(limit)


func _on_start_pressed() -> void:
	global.in_match = true
	global.current_bot = load(global.bots[$"select Bot".get_item_text($"select Bot".get_selected_id())]["path"])
	global.match_settings["points_win"] = int($TextEdit.text)
	get_tree().change_scene_to_file("res://scenes/world.tscn")
