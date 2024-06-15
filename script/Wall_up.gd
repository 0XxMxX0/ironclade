extends Area2D


func _on_area_entered(area):
	if area.is_in_group("Bullet") or area.is_in_group("Bullet_enemy") :
		area.queue_free()
