extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		$background.color = '#1e010508'
	
func _on_body_exited(body):
	if body.is_in_group("Player"):
		$background.color = '#222034'
