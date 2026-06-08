extends TextureButton
var is_hovered = false

func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://Assets/Core/map_scene.tscn")

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false
