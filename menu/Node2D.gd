extends Node2D

func _on_texture_button_button_down():
	var result = get_tree().change_scene_to_file("res://scenes/level_01.tscn")
	if result != OK:
		print("Error changing scene to Game: ", result)
	else:
		print("Scene changed successfully")


func _on_texture_button_2_button_down():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
								linear_to_db(value))
