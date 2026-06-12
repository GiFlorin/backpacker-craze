extends Node2D
@onready var progress_bar: ProgressBar = $GUI/ProgressBar
@onready var start_lbl: Label = $GUI/start_lbl

var game_stage = START

enum {
	START,
	CATCH_WAVE,
	STAY_ON_WAVE,
	NEW_STUDENT,
	RESULTS
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PauseMenu.active = true
	game_stage = START
	start_lbl.visible = true

func _enter_tree() -> void:
	request_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match game_stage:
		START:
			new_round()
		CATCH_WAVE:
			catch_wave()
		STAY_ON_WAVE:
			stay_on_wave()
		NEW_STUDENT:
			new_round()
		RESULTS:
			end_round()

func new_round():
	game_stage = 0
	progress_bar.visible = false
	progress_bar.value = 0
	if Input.is_action_just_pressed("Jump"):
		game_stage = CATCH_WAVE
		start_lbl.visible = false

func catch_wave():
	pass

func stay_on_wave():
	progress_bar.visible = true

func new_student():
	pass

func end_round():
	pass
