extends Node2D

@onready var game_timer: Timer = $game_timer
@onready var timer_lbl: Label = $timer_lbl

var secs = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_time()

func stay_on_board():
	pass

func update_time():
	game_timer.wait_time = 1.0
	if game_timer.is_stopped():
		secs += 1
		game_timer.start()
	timer_lbl.text = str(secs)
