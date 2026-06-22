extends Node2D

func _ready() -> void:
	GameManager.cur_destination = GameManager.START

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('Jump'):
		SceneTransition.change_scene("res://Assets/Core/journal/journal.tscn")
