extends Node

#Paramentos gerais do player
@onready var player_position: Vector2
@onready var player

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
		"probability": 0.5,
		"attribute": {
			"attribute": "speed",
			"value": 2
		},
		"category": "attribute"
	},
	"rifle" :{
		"name": "rifle",
		"sprite": "res://assents/power_ups/rifle.png",
		"probability": 0.3,
		"attribute": {},
		"category": "weapon"
	},
	"metralhadora" :{
		"name": "metralhadora",
		"sprite": "res://assents/power_ups/metralhadora.png",
		"probability": 0.2,
		"attribute": {},
		"category": "weapon"
	}
}

##Mecanica de troca de arma
var player_weapon_changer: bool = false
var weapons = {
	"pistola":{
		"attribute":{
			"attaking_cooldown" : 0.8,
			"recharge_cooldown" : 1.5,
			"damage": 2,
			"ammunition": 5
		}
	},
	"rifle":{
		"attribute":{
			"attaking_cooldown" : 2.5,
			"recharge_cooldown" : 2.5,
			"damage": 5,
			"ammunition": 1
		}
	},
	"metralhadora":{
		"attribute":{
			"attaking_cooldown" : 0.1,
			"recharge_cooldown" : 1.0,
			"damage": 3,
			"ammunition": 10
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
