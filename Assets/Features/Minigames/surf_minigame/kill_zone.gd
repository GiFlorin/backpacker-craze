extends Area2D
var game

func _ready():
	game = get_tree().current_scene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		print('die')
		game.die()
