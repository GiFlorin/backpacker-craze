extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene(target: String, animation: String = 'dissolve') -> void:
	match animation:
		'dissolve':
			dissolve_transition(target)
		'clouds':
			clouds_transition(target)
		_:
			get_tree().change_scene_to_file(target)

func dissolve_transition(target: String):
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("dissolve")

func clouds_transition(target: String):
	animation_player.play("clouds_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play("clouds_out")
