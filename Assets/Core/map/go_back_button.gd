extends Button

func _on_pressed() -> void:
	close_map()

func close_map():
	if GameManager.previous_scene == "":
		return  # safety check
	get_tree().change_scene_to_file(GameManager.previous_scene)
