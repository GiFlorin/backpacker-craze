extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var is_physics_enabled = false

const JUMP_VELOCITY = -200.0

func _ready() -> void:
	is_physics_enabled = false

func enable_physics():
	is_physics_enabled = true
	animation_player.play("go_away_teacher")
	await animation_player.animation_finished
	$character.visible = false

func _physics_process(delta: float) -> void:
	if is_physics_enabled:
		# Add the gravity.
		velocity += (get_gravity()/2) * delta
		# Handle jump.
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
		move_and_slide()
