extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/points_lbl.text = 'You made %s points in total' % str(GameManager.past_job_points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_restart_button_pressed() -> void:
	SceneTransition.change_scene("res://Assets/Features/Minigames/surf_minigame/surfing_mini.tscn")

func _on_go_back_button_pressed() -> void:
	SceneTransition.change_scene(GameManager.previous_scene)
