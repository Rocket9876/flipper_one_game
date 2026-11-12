extends Control

func _ready() -> void:
	if global.score["bottem"] > global.score["top"]:
		$winner.text = "YOU WON!"
	else:
		$winner.text = global.current_bot_name + " WON!"
	global.score["bottem"] = 0
	global.score["top"] = 0


func _on_back_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start___page.tscn")
