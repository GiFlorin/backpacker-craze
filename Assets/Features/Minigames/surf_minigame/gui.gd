extends Node2D

@onready var game_timer: Timer = $game_timer
@onready var timer_lbl: Label = $timer_lbl
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var board_timer: Timer = $board_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_lbl.text = "%.f" % game_timer.time_left
	progress_bar.value = board_timer.wait_time - board_timer.time_left

func stay_on_board():
	progress_bar.visible = true
	board_timer.wait_time = 20
	progress_bar.max_value = board_timer.wait_time
	if board_timer.is_stopped():
		board_timer.start()
