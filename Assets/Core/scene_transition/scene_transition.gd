extends CanvasLayer

func change_scene(target: String, animation: String = 'dissolve') -> void:
	match animation:
		'dissolve':
			dissolve_transition(target)
		'clouds':
			clouds_transition(target)
		_:
			get_tree().change_scene_to_file(target)

func dissolve_transition(target: String):
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")

func clouds_transition(target: String):
	$AnimationPlayer.play("clouds_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("clouds_out")
