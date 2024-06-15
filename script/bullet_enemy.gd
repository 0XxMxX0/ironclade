class_name Bullet_enemy
extends Area2D

var direction: Vector2 = Vector2.ZERO

func _ready():
	randomize()
	direction = global_position.direction_to(GameManager.player_position)
	
	#Rotacionando a bala para a direção do tiro
	var angle = direction.angle()
	rotation_degrees = rad_to_deg(angle)

func _physics_process(delta) -> void:
	translate(direction * delta * 180)
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		if GameManager.player_is_dodging:
			return
		body.damage(5)
		queue_free()
