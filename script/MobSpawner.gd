class_name MobSpawner
extends Node2D

@export var enemies: Array[PackedScene]
var mobs_per_minute: float = 10.0

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
var cooldown: float = 0.0

func _process(delta):
	#Temporizador
	cooldown -= delta
	if cooldown > 0: return
	
	#Frequencia de spawn por minuto
	var interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	var index = randi_range(0, enemies.size() - 1)
	var enemies_scene = enemies[index]
	var enemy = enemies_scene.instantiate()
	
	#Pegar um ponto aleatorio
	var point = get_point()
	
	#Colocar o enemy na posição
	enemy.global_position = point
	#get_parent().add_child(enemy)

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
