extends Control

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/level_01.tscn")
		GameManager.game_over = false
		GameManager.player_dodge = false
		GameManager.player_extra = null
		GameManager.drop_1_colected = false
		GameManager.door_2_open = false
		GameManager.player_weapon
		GameManager.weapon_changer = false
		GameManager.damage_to_player
		GameManager.libert_player_2 = false
		GameManager.libert_player_1 = false
		GameManager.group_1 = 3
		GameManager.group_2 = 4
		GameManager.tutorial = true
