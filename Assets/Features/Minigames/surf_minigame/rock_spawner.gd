extends Area2D
@onready var timer: Timer = $Timer
@onready var rock: RigidBody2D = $"../rock"

var min_y = -140
var max_y = -340
var max_x = -600
var active = false
var rocks = []

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
	rocks.append(rock.duplicate(15))
	rocks.back().position = Vector2(position.x, randf_range(max_y, min_y))
	add_sibling(rocks.back())
	
