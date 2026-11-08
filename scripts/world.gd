extends Node2D

var mouse_quadrant

func _ready() -> void:
	pass

func flip(path):
	path.flip()


func _physics_process(delta: float) -> void:
	flip($"kicker/flipper_bottem_left")
	flip($"kicker/flipper_bottem_right")
	mouse_quadrant = Vector2(get_number_dir(get_global_mouse_position().x),get_number_dir(get_global_mouse_position().y))
	#print(get_current_flipper())
	#print(mouse_quadrant)

func get_number_dir(number):
	if number > 0:
		return 1
	else:
		return 0

func fliping():
	pass


func get_current_flipper():
	
	return get_node("kicker/flipper_" + ["top","bottem"][mouse_quadrant.y] + "_" + ["left","right"][mouse_quadrant.x])
