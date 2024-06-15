class_name Enemy
extends CharacterBody2D

var player

@export var group = 1

#Movimentação
var input_vector: Vector2 = Vector2.ZERO
var speed: float = 0.5
#Propriedades de vida
var health: int = 10

#Propriedade de ataque
var damage_to_enemy: int = 5
var is_attacking: bool = false
var attacking_cooldown = 0
const BULLET: PackedScene = preload("res://scenes/bullet_enemy.tscn")
@onready var texture: Sprite2D = $texture

func _process(delta) -> void:
	if GameManager.game_over: return

	player = GameManager.player
	
	#Tempo de ataque do inimigo
	attacking_cooldown += delta
	if attacking_cooldown > 3:
		is_attacking = false
		attacking_cooldown = 0
		return
	
	if not is_attacking:
		var bodies = $hitArea.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Player"):
				if player != null:
					spawn_bullet()
					$Hand/animation_weapon.play("default")
					is_attacking = true

func spawn_bullet() -> void:
	var bullet = BULLET.instantiate()
	bullet.global_position = %weapon_barrel.global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", bullet)
	
func damage(value: int) -> void:
	health -= value
	
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(tween.EASE_IN)
	tween.set_trans(tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	if self.texture.flip_h:
		self.position.x += 20
	else:
		self.position.x -= 20
	
	if health <= 0:
		$animation.play("died")
	print("Inimigo recebeu ",value," de dano e ficou com ", health," de vida")
	
func dead() -> void:
	if group == 1:
		GameManager.group_1 -= 1
	elif group == 2:
		GameManager.group_2 -= 1
	print('Inimigo morreu')
	queue_free()
