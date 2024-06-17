class_name Player
extends CharacterBody2D

#Propriedades gerais do player
var health: int = 20
var speed: float = 1.5

#Propriedades de movimentação
var input_vector: Vector2 = Vector2.ZERO
var direction_player

##Propriedades de corrida
var is_running: bool = false
var was_running: bool = false

##Area de ataque
@onready var hit_area: Area2D = $hitArea
var is_receive_damage = false

#Propriedades do braço
@onready var hand: Node2D = $Hand

#Animation
@onready var animation: AnimationPlayer = $animation
#Sprite
@onready var sprite: Sprite2D = $texture

func _process(delta) -> void:
	#Passando informações globais do player
	GameManager.player = self
	GameManager.player_position = position
	
	#Ler a tecla digitada
	read_input()
	
	#Processar rotação do sprite
	rotate_sprite()
	
	if not is_receive_damage:
		#Processa animações basicas
		play_run_idle_animation()

func _physics_process(delta) -> void:
	#Processa a movimentação
	var target_velocity = input_vector * speed * 100
	
	velocity = lerp(velocity, target_velocity, 0.09)
	move_and_slide()
		
	#Processar direção do braço
	hand.animate(get_direction_mouse(), get_mouse_position())

func read_input() -> void:
	if GameManager.game_over: return
	
	if Input.is_action_just_pressed("dodge") and input_vector != Vector2(0,0):
		animation.play("dodge")
		GameManager.player_is_dodging = true
	
	#print(GameManager.player_is_dodging)
	
	if not GameManager.player_is_dodging:	
		#Capta a direção
		input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.15)
		
		#Atualiza as propriedades de corrida
		was_running = is_running
		is_running = not input_vector.is_zero_approx()

func play_run_idle_animation() -> void:
	if was_running != is_running:
		if is_running:
			if input_vector.y < 0:
				animation.play("run_top")
				is_running = false
			elif input_vector.y > 0:
				animation.play("run_down")
				is_running = false
			else:
				animation.play("run_horizontal")
				is_running = false
		else:
			is_running = false
			animation.play('idle')
	else:
		if not GameManager.player_is_dodging:
			animation.play('idle')
			input_vector = Vector2.ZERO

func rotate_sprite() -> void:
	if GameManager.game_over: return
	#Girando o sprite de acordo com o mouse
	
	if get_direction_mouse().x > 0:
		sprite.flip_h = false
		direction_player = 'horizontal r'
		animation.play("")
		sprite.position.x = 2.325
		%gun_barrel.position.y = 0.388
	elif get_direction_mouse().x < 0:
		sprite.flip_h = true
		direction_player = 'horizontal l'
		sprite.position.x = -3.617
		%gun_barrel.position.y = -1

func damage(value) -> void:
	if GameManager.game_over: return
	
	is_receive_damage = true
	GameManager.player_is_dodging = false
	
	health -= value
	animation.play("hit")
	if health <= 0:
		die()
	print("Jogador recebeu ",value," de dano e ficou com ",health," de vida")

func die() -> void:
	GameManager.game_over = true
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	animation.play("dead")

#Pegando a posição do mouse
func get_direction_mouse() -> Vector2:
	return global_position.direction_to(get_mouse_position())

func get_mouse_position() -> Vector2:
	return get_global_mouse_position()
	
func player_dodge_not():
	GameManager.player_is_dodging = false
	
func player_receive_damage():
	is_receive_damage = false
