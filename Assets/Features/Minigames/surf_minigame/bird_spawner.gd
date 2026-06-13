extends Area2D
@onready var timer: Timer = $Timer
@onready var bird: RigidBody2D = $"../bird"

var min_y = -340
var max_y = -700
var max_x = -600
var active = false
var birds = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	active = true
	timer.wait_time = randf_range(1, 4)
	timer.start()

func _on_timer_timeout() -> void:
	spawn()

func spawn():
	birds.append(bird.duplicate(15))
	birds.back().position = Vector2(position.x, randf_range(max_y, min_y))
	add_sibling(birds.back())
