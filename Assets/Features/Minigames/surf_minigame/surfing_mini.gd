extends Node2D
@onready var start_lbl: Label = $GUI/start_lbl
@onready var meter: Node2D = $GUI/meter
@onready var timer_lbl: Label = $GUI/timer_lbl
@onready var game_timer: Timer = $GUI/game_timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gui: Node2D = $GUI
@onready var player: CharacterBody2D = $player_area


var game_stage = START
var student_count: int = 0
var release_points = 0

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
	meter.visible = false
	student_count = 0

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
	release_points = 0
	if Input.is_action_just_pressed("Jump"):
		game_stage = CATCH_WAVE
		start_lbl.visible = false

func catch_wave():
	meter.visible = true
	timer_lbl.visible = true
	
	meter.start()
	if !animation_player.is_playing():
		var animation_name = ["wave_moving", "small_wave_move", "medium_wave_move"].pick_random()
		animation_player.play(animation_name)

func release(rp):
	game_stage = STAY_ON_WAVE
	release_points = rp

func stay_on_wave():
	gui.stay_on_board()
	$obstacles.start()
	player.enable_physics()

func new_student():
	pass

func end_round():
	GameManager.past_job_points = release_points * gui.secs # TO DO
	SceneTransition.change_scene("res://Assets/Features/Minigames/surf_minigame/results_surf.tscn")

func die():
	game_stage = end_round()
