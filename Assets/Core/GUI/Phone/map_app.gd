extends TextureButton
@export var Player: CharacterBody2D
var is_hovered = false

func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://Assets/Core/map/map_scene.tscn")

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false

func open_map():
	# Save current state
	GameManager.previous_scene = get_tree().current_scene.scene_file_path

	# Go to map
	get_tree().change_scene_to_file("res://scenes/Map.tscn")
