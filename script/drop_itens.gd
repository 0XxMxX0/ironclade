extends Area2D

var power_up
var position_init_y
var position_y_max = false

func _ready():
	#Gera o POWER UP
	power_up = generete_power_up()
	$texture_drop_itens.set_texture(load(power_up['sprite']))
	position_init_y = position.y
	
func _process(delta):
	
	#Codigo para animar o power-up
	if position.y >= position_init_y + 8 and not position_y_max:
		position_y_max = true
	elif position.y <= position_init_y and position_y_max:
		position_y_max = false
	else:
		if position.y < position_init_y + 8 and not position_y_max:
			position.y += 0.2
		elif position.y > position_init_y and position_y_max:
			position.y -= 0.2
			
func generete_power_up():
	#Chances de aparecer cada item
	var random_number = randf()
	var soma_probabilidades = 0.0
	
	for power_up in GameManager.power_ups:
		soma_probabilidades += GameManager.power_ups[power_up]['probability']
		if random_number < soma_probabilidades:
			return GameManager.power_ups[power_up]

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if power_up['category'] == 'weapon':
			HandBag.player_items['weapon'] = power_up['name']
			GameManager.player_weapon_changer = true
		elif power_up['category'] == 'attribute':
			if len(HandBag.player_items['up']) == 0:
				HandBag.player_items['up'].append({'att': power_up['name']})
			else:
				for attribute in HandBag.player_items['up']:
					if attribute['att'] != power_up['name']:
						HandBag.player_items['up'].append({'att': power_up['name']})
		
		$drop.play(0.0)
		$drop.autoplay = true
func _on_body_exited(body):
	#pass
	queue_free()
