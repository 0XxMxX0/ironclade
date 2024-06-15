extends Control
var etapa = 0
var cooldown = 0
func _process(delta):
	cooldown += delta
	if cooldown > 5 and etapa == 0:
		etapa = 1
	
	if GameManager.tutorial:
		if etapa == 1 and Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("dodge"):
			%Label.text = 'Teste de Inteligência Artificial número 2: 
							Ataque Aperte o botão direito do mouse para atirar e botão
							direito do mouse para rolar e desviar.'
			etapa = 2
		
		if etapa == 2 and Input.is_action_just_pressed("attack"):
			GameManager.tutorial = false 
			queue_free()
