extends Node

@onready var enemy: Enemy = get_parent()
@onready var hand = %Hand
func _physics_process(delta) -> void:
	if enemy.group == 2:
		if not GameManager.door_2_open:
			return
		if not GameManager.libert_player_2:
			return
	if enemy.group == 1:
		if not GameManager.libert_player_1:
			return
			
	var bodies = %hitArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Player"):
			if GameManager.player != null:
				return
	
	#Pegando posição do player
	var player_position = GameManager.player_position
	
	#Diferença entre o player e o inimigo
	var difference = player_position - enemy.position
	var distance_to_player = difference.length()
	
	
	if distance_to_player < 35: return
	
	#Normalizando distancia
	enemy.input_vector = difference.normalized()
	
	#Movimentação
	enemy.velocity = enemy.input_vector * enemy.speed * 100.0
	
	#Rotação
	if enemy.input_vector.x > 0:
		enemy.texture.flip_h = false
		#%weapon.flip_h = false
		%weapon.position.x = 3.776
	elif enemy.input_vector.x < 0:
		enemy.texture.flip_h = true
		#%weapon.flip_h = true
		%weapon.position.x = 5
	hand.look_at(GameManager.player_position)
		
	if enemy.is_attacking or GameManager.game_over:
		return 
	enemy.move_and_slide()
