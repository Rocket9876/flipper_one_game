extends Node2D



func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("ball"):
		body.activate_speed()
		global.world.powerup_spawned = false
		self.queue_free()
