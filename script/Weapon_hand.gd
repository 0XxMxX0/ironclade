extends Node2D

const BULLET: PackedScene = preload("res://scenes/bullet.tscn")

@onready var animation = $"../animation"
var is_attaking: bool = false
var attaking_cooldown = 0

#Propriedades da arma
@onready var weapon_texture: Sprite2D = $weapon
var ammunition = 5

func _process(delta):
	pass
	
	#troca de arma
	if HandBag.player_items['weapon'] != 'pistola':
		pass
		#if GameManager.player_extra == "rifle":
			#GameManager.player_weapon = 'rifle'
			#%animation_weapon.play("rifle")
			#GameManager.player_extra = null
			#GameManager.weapon_changer = true
		#elif GameManager.player_extra == "velocidade":
			##speed = 3
			#GameManager.player_extra = null

func _physics_process(delta):
	pass
	#print(attaking_cooldown)
	
	#atualizando tempo de ataque
	#attaking_cooldown += delta
	#if ammunition <= 0:
		#weapon_texture.set_texture(preload('res://addons/weapons/arma_descarregada.png'))
		#if attaking_cooldown > 2:
			#is_attaking = false
			#attaking_cooldown = 0
			#ammunition = 5
			#weapon_texture.set_texture(preload('res://addons/weapons/arma_carregada.png'))
			#return
	#else:
		#if attaking_cooldown > 0.5:
			#is_attaking = false
			#attaking_cooldown = 0
			#return
	#
	#if Input.is_action_just_pressed("attack") and not is_attaking and ammunition != 0:
		#animation.play("attack")
		#ammunition -= 1
		#is_attaking = true

func spawn_bullet() -> void:
	var bullet = BULLET.instantiate()
	bullet.global_position = $weapon_barrel.global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", bullet)

func animate(attack_direction, direction):
	if attack_direction.x > 0:
		$weapon.flip_v = false
		$weapon.position.y = 0.5
		$weapon.position.x = 5.426
	elif attack_direction.x < 0:
		$weapon.flip_v = true
		$weapon.position.y = 10.00
		$weapon.position.x = 6.42
	look_at(direction)
