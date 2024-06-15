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

##Mecanica de atribuição de atributos
var player_add_attribute = null
##Mecanica de troca de arma
var player_weapon_changer = null


func _process(delta):
	if group_2 <= 0:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
		print('acabou o jogo')
