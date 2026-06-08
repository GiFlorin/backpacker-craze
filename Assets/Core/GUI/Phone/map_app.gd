extends TextureButton
@export var Player: CharacterBody2D
var is_hovered = false

func _on_button_down() -> void:
	open_map()

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false

func open_map():
	# Save current state
	GameManager.previous_scene = get_tree().current_scene.scene_file_path

	# Go to map
	SceneTransition.change_scene("res://Assets/Core/map/map_scene.tscn")
