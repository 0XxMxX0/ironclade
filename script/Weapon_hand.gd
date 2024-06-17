extends Node2D

#Cena da munição
const BULLET: PackedScene = preload("res://scenes/combat/bullet.tscn")

#Propriedade de combate
var is_attaking: bool = false

#Propriedade da arma atual
var weapon
var ammunition
var attaking_cooldown = 0
@onready var texture: Sprite2D = $texture

#Animação da arma atual
@onready var animation = $animation

func _ready():
	weapon = GameManager.weapons[HandBag.player_items['weapon']]
	ammunition = weapon['attribute']['ammunition']
	animation.play(str(HandBag.player_items['weapon']))
	
func _process(delta):
	
	#print(GameManager.player_weapon_changer)
	if GameManager.player_weapon_changer:
		weapon = GameManager.weapons[HandBag.player_items['weapon']]
		ammunition = weapon['attribute']['ammunition']
		animation.play(str(HandBag.player_items['weapon']))
		GameManager.player_weapon_changer = false
		
	#atualizando tempo de ataque
	attaking_cooldown += delta
	if ammunition == 0:
		if attaking_cooldown >= weapon['attribute']['recharge_cooldown']:
			is_attaking = false
			attaking_cooldown = 0
			animation.play(str(HandBag.player_items['weapon']))
			ammunition = weapon['attribute']['ammunition']
		else:
			if animation.get_current_animation() != HandBag.player_items['weapon']+"_descarregada":
				animation.play(str(HandBag.player_items['weapon']+"_descarregada"))
	else:
		if attaking_cooldown > weapon['attribute']['attaking_cooldown']:
			is_attaking = false
			attaking_cooldown = 0
			
	if Input.is_action_just_pressed("attack") and not is_attaking and ammunition != 0:
		spawn_bullet()
		$gun_audio.play(0.0)
		$gun_audio.autoplay = true
		ammunition -= 1
		is_attaking = true

func spawn_bullet() -> void:
	var bullet = BULLET.instantiate()
	bullet.global_position = %gun_barrel.global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", bullet)

func animate(attack_direction, direction):
	if attack_direction.x > 0:
		texture.flip_v = false
		texture.position.x = 4.5
		texture.position.y = -5
	elif attack_direction.x < 0:
		texture.flip_v = true
		texture.position.x = 4.5
		texture.position.y = 5
	look_at(direction)
