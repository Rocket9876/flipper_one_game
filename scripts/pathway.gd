extends Control

@export var max_position = {"top":0,"bottem":0}


@export var scroll_speed:float

func _input(event: InputEvent) -> void:
	if event.is_action("wheel down"):
		if $pathway_elements.position.y - scroll_speed > max_position["top"]:
			$pathway_elements.position.y -= scroll_speed
	elif event.is_action("wheel up"):
		if not $pathway_elements.position.y + scroll_speed > max_position["bottem"]:
			$pathway_elements.position.y += scroll_speed
