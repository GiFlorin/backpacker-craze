extends Button

func _on_pressed() -> void:
	close_map()

func close_map():
	if GameManager.previous_scene == "":
		return  # safety check
	SceneTransition.change_scene(GameManager.previous_scene)
