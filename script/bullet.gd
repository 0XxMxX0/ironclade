class_name Bullet
extends Area2D

var direction: Vector2 = Vector2.ZERO
@onready var player = GameManager.player
func _ready():
	randomize()
	direction = global_position.direction_to(get_global_mouse_position())
	
	#Rotacionando a bala para a direção do tiro
	var angle = direction.angle()
	rotation_degrees = rad_to_deg(angle)

func _physics_process(delta) -> void:
	translate(direction * delta * 512.0)
	
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(GameManager.damage_to_player)
		queue_free()
