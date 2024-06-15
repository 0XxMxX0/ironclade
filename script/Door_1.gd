extends CharacterBody2D

func _process(delta):
	if GameManager.group_1 == 0 and not $collission.disabled:
		$collission.disabled = true
		$animation.play("open_door")
		print('Porta vai se abrir!')
