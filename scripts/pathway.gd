extends Control

@export var max_position = {"top":0,"bottem":0}

var mouse_click_pos

@export var scroll_speed:float

func _input(event: InputEvent) -> void:
	if event.is_action("wheel down"):
		if $pathway_elements.position.y - scroll_speed > max_position["top"]:
			$pathway_elements.position.y -= scroll_speed
	elif event.is_action("wheel up"):
		if not $pathway_elements.position.y + scroll_speed > max_position["bottem"]:
			$pathway_elements.position.y += scroll_speed
	mouse_drag()


func mouse_drag():
	if Input.is_action_pressed("click"):
		if not mouse_click_pos:
			mouse_click_pos = get_global_mouse_position()
		$pathway_elements.position.y = get_global_mouse_position().y - mouse_click_pos.y
		if $pathway_elements.position.y > max_position["bottem"]:
			$pathway_elements.position.y = max_position["bottem"]
			mouse_click_pos = get_global_mouse_position()
	else:
		mouse_click_pos = null
		
