extends Node2D
@onready var meter_timer: Timer = $meter_timer
@onready var pointer: ColorRect = $pointer

var status = 0
var active = false
var go: bool = true
var percentage: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# calculate pointer rotate degrees
	if active:
		percentage = (meter_timer.wait_time - meter_timer.time_left) * 100 / meter_timer.wait_time
		if go:
			pointer.rotation_degrees = 1.8 * percentage - 90
		elif !go:
			pointer.rotation_degrees = -1.8 * percentage + 90
	else:
		visible = false

func _input(event: InputEvent) -> void:
	if active:
		if Input.is_action_just_pressed("Jump"):
			var p:float = meter_timer.wait_time
			var a = 3
			var x = meter_timer.time_left
			var release_points = ceil(a - ( 2 * a/p ) * abs(x - (p / 2) ))
			self.get_parent().get_parent().release(release_points)
			active = false
			

# main script calls this to initialize the meter
func start():
	if !active:
		meter_timer.wait_time = randf_range(1, 3)
		meter_timer.start()
		active = true
		go = true

# when the timer runs out, you start again and change pointer direction
func _on_meter_timer_timeout() -> void:
	meter_timer.start()
	go = !go
