extends Area2D

var power_up = {
	'nome' = '',
	'category' = ''
}

func _ready():
	
	#Chance de randomizar o item
	var random_item = randi_range(1,4)
	var item_preload = preload('res://addons/velocidade.png')
	
	#Chances de aparecer cada item
	# - Rifle 50% de chance
	if random_item < 2:
		power_up['nome'] = 'rifle'
		power_up['category'] = 'weapon'
		item_preload = preload('res://addons/rifle.png')
	else:
		power_up['nome'] = 'velocidade'
		power_up['category'] = 'attribute'
		item_preload = preload('res://addons/velocidade.png')
		
	#Gera o POWER UP
	$texture_drop_itens.set_texture(item_preload)
	
#func _process(delta):
	#if GameManager.drop_1_colected:
		#queue_free()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if power_up['category'] == 'weapon':
			GameManager.player_weapon_changer = power_up['nome']
			
		elif power_up['category'] == 'attribute':
			GameManager.player_add_attribute = power_up['nome']
		
		#$drop.play(0.0)
		#$drop.autoplay = true
		#GameManager.door_2_open = true
		#GameManager.drop_1_colected = true
#
#func _on_body_exited(body):
	#pass
	##queue_free()
