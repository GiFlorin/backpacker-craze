extends CharacterBody2D

var speed = 600

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func _enter_tree() -> void:
	if GameManager.player_position != Vector2.ZERO:
		position = GameManager.player_position

func _exit_tree() -> void:
	GameManager.previous_scene = get_tree().current_scene.scene_file_path
	GameManager.player_position = self.global_position 
