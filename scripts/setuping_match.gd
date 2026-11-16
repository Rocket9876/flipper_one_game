extends Control

var limit = 99

func _ready() -> void:
	$"select Bot 1".item_count = global.bots.size()
	$"select Bot 2".item_count = global.bots.size()
	var count = 0
	for i in global.bots:
		$"select Bot 1".set_item_text(count,i)
		$"select Bot 2".set_item_text(count,i)
		count += 1



func _on_text_edit_text_changed() -> void:
	if int($TextEdit.text) > limit:
		$TextEdit.text = str(limit)


func _on_start_pressed() -> void:
	if $"against bot".button_pressed:
		if $bot_vs_bot.button_pressed:
			global.match_settings["bot vs bot"] = true
			global.current_bots = [load(global.bots[$"select Bot 1".get_item_text($"select Bot 1".selected)]["path"]).new(),load(global.bots[$"select Bot 2".get_item_text($"select Bot 2".selected)]["path"]).new()]
			global.bot["name"] = $"select Bot 1".get_item_text($"select Bot 1".selected)
			global.bot_2["name"] = $"select Bot 2".get_item_text($"select Bot 2".selected)
			global.current_bots[0].side = "top"
			global.current_bots[1].side = "bottem"
		else:
			global.current_bot = load(global.bots[$"select Bot 1".get_item_text($"select Bot 1".selected)]["path"]).new()
			global.current_bot_name = $"select Bot 1".get_item_text($"select Bot 1".selected)
			global.bot["name"] = $"select Bot 1".get_item_text($"select Bot 1".selected)
	else:
		global.current_bot = null
		global.current_bot_name = ""
	global.match_settings["points_win"] = int($TextEdit.text)
	global.match_settings["pathway_match"] = false
	global.match_settings["powerups"] = $powerups.button_pressed
	global.match_settings["bot"] = $"against bot".button_pressed
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	#global.match_start()


func _on_local_1v_1_toggled(toggled_on: bool) -> void:
	if not $bot_vs_bot.button_pressed:
		$"select Bot 1".visible = toggled_on
	$bot_vs_bot.visible = toggled_on


func _on_bot_vs_bot_toggled(toggled_on: bool) -> void:
	$"select Bot 2".visible = toggled_on
	if not $"against bot".button_pressed:
		$"select Bot 1".visible = toggled_on
