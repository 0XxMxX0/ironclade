extends Node

#Paramentos gerais do player
@onready var player_position: Vector2
@onready var player
var player_is_dodging = false
var damage_to_player

#Paramentros gerais do jogo
var game_over = false
var drop_1_colected = false
var door_2_open = false
var libert_player_2 = false
var libert_player_1 = false
var group_1 = 3
var group_2 = 4
var tutorial = true

#GERENCIAMENTO DE POWER-UPS
var power_up = {}

##Mecanica de troca de arma
var player_weapon_changer = null

func _process(delta):
	if group_2 <= 0:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
		print('acabou o jogo')
		
	#Controle e gerenciamento dos atributos do player
	control_attribute()
	
	#Controle de powerUps
	add_power_up()

func control_attribute():
	if len(HandBag.player_items['up']) != 0:
		for attribute in HandBag.player_items['up']:
			if attribute['att'] == 'velocidade':
				player.speed = 2

func set_power_up(name, sprite, category):
	pass
	#power_up.append({
		#'name': name,
		#'sprite': sprite,
		#'category': category
	#})
	
func add_power_up():
	set_power_up('rifle', 'res://assents/power_ups/Rifle.png', 'weapon')
	set_power_up('velocity', 'res://assents/power_ups/velocidade.png', 'attribute')
