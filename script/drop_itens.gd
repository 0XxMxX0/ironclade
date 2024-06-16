extends Area2D

var power_up

func _ready():
	
	#Chance de randomizar o item
	var random_int = randi_range(1,4)
	
	#Gera o POWER UP
	#$texture_drop_itens.set_texture(preload())
	
#func _process(delta):
	#if GameManager.drop_1_colected:
		#queue_free()

func generete_power_up(random_int) -> String:
	#Chances de aparecer cada item
	# - Rifle 50% de chance
	if random_int < 0:
		return 'rifle'
	else:
		return 'velocidade'
	

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if power_up['category'] == 'weapon':
			GameManager.player_weapon_changer = power_up['name']
			
		elif power_up['category'] == 'attribute':
			print(len(HandBag.player_items['up']))
			if len(HandBag.player_items['up']) == 0:
				HandBag.player_items['up'].append({'att': power_up['name']})
			else:
				for attribute in HandBag.player_items['up']:
					if attribute['att'] != power_up['name']:
						HandBag.player_items['up'].append({'att': power_up['name']})
		
		#$drop.play(0.0)
		#$drop.autoplay = true
		#GameManager.door_2_open = true
		#GameManager.drop_1_colected = true
#
#func _on_body_exited(body):
	#pass
	##queue_free()
