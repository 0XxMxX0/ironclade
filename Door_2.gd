extends CharacterBody2D

func _process(delta):
	if GameManager.door_2_open and not $collission.disabled:
		$collission.disabled = true
		$animation.play("open_door")
		print('Porta vai se abrir!')
