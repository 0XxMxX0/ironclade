extends Node

#Paramentos gerais do player
@onready var player_position: Vector2
@onready var player
var player_is_dodging = false

#Paramentros gerais do jogo
var game_over = false
var drop_1_colected = false
var door_2_open = false
var libert_player_2 = false
var libert_player_1 = false
var group_1 = 3
var group_2 = 4
var tutorial = true

#GERENCIAMENTO DE POWER-UPS/WEAPONS
var power_ups = {
	"velocity" :{
		"name": "velocity",
		"sprite": "res://assents/power_ups/velocidade.png",
		"probability": 0.1,
		"attribute": {
			"attribute": "speed",
			"value": 2
		},
		"category": "attribute"
	},
	"rifle" :{
		"name": "rifle",
		"sprite": "res://assents/power_ups/rifle.png",
		"probability": 0.9,
		"attribute": {},
		"category": "weapon"
	}
}

##Mecanica de troca de arma
var player_weapon_changer: bool = false

var weapons = {
	"pistola":{
		"sprites": {
			"skin_pattern": "res://assents/weapons/pistola.png",
			"skin_second": "res://assents/weapons/pistola_descarregada.png",
		},
		"attribute":{
			"attaking_cooldown" : 0.8,
			"recharge_cooldown" : 1.5,
			"damage": 2,
			"ammunition": 5
		}
	},
	"rifle":{
		"sprites": {
			"skin_pattern": "res://assents/weapons/rifle.png",
			"skin_second": "res://assents/weapons/Rifle_descarregada.png",
		},
		"attribute":{
			"attaking_cooldown" : 2.5,
			"recharge_cooldown" : 2.5,
			"damage": 5,
			"ammunition": 1
		}
	}
}



func _process(delta):
	if group_2 <= 0:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
		print('acabou o jogo')
		
	#Controle e gerenciamento dos atributos do player
	control_attribute()
	
func control_attribute():
	if len(HandBag.player_items['up']) != 0:
		for attribute in HandBag.player_items['up']:
			if attribute['att'] == 'velocidade':
				player.speed = 2
