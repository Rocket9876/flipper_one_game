extends Button

@export_file_path() var path



func _on_pressed() -> void:
	get_tree().change_scene_to_file(path)
