extends Node2D

enum Phase {
	IDLE,           # waiting to start
	CAST_READY,     # arrow rotating, waiting for Space
	FLOAT_LANDING,  # float tweens to position
	CHECKING,       # brief pause — is a fish nearby?
	NO_FISH,        # no fish, show message, then next cast
	WAITING_NIBBLE, # gentle bob, fish approaching
	FALSE_BOB,      # quick shallow dip — trap
	TRUE_DIP,       # real bite — timing window open
	CAUGHT,         # success animation
	MISSED,         # window expired
	SPOOKED,        # player pressed on false bob
	ROUND_END       # show results screen
}

# ── Exports ──────────────────────────────────────────────────────────────────
@export var total_casts: int = 5
@export var cast_distance: float = 280.0   # TODO - variable distance   # how far the float travels
@export var arrow_rotation_speed: float = 1.8 # radians/sec
@export var fish_scene: PackedScene

# ── Node references ───────────────────────────────────────────────────────────
@onready var cast_arrow: Node2D       = $cast_arrow
@onready var cast_origin: Marker2D   = $cast_origin
@onready var float_node: Node2D       = $float
@onready var fish_container: Node2D   = $waterzone/fish_container
@onready var casts_label: Label       = $UI/casts_label
@onready var score_label: Label       = $UI/score_label
@onready var phase_hint: Label        = $UI/phase_hint
@onready var result_screen: Control   = $UI/result_screen

# ── State ─────────────────────────────────────────────────────────────────────
var current_phase: Phase = Phase.IDLE
var casts_remaining: int
var score: int = 0
var fish_caught: int = 0
var nearby_fish: Node2D = null   # the fish that took interest in this cast
var cast_time_start: float       # used to detect perfect timing

# ── Money reward thresholds ───────────────────────────────────────────────────
const MONEY_TIERS := {
	0:  10,   # showed up, tried
	4:  20,   # decent session
	8:  35,   # good fisher
	13: 50    # rare fish specialist
}

# ─────────────────────────────────────────────────────────────────────────────

func _ready() -> void:
	result_screen.hide()
	float_node.hide()
	spawn_fish()
	casts_remaining = total_casts
	update_hud()
	set_phase(Phase.CAST_READY)

func _process(delta: float) -> void:
	match current_phase:
		Phase.CAST_READY:
			# Rotate the arrow around the cast origin
			cast_arrow.rotation += arrow_rotation_speed * delta
		
		Phase.TRUE_DIP:
			# Detect perfect timing — first 40% of window = bonus
			pass  # handled inside the nibble coroutine

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_accept"):  # Space / A button
		return
	match current_phase:
		Phase.CAST_READY:
			do_cast()
		Phase.FALSE_BOB:
			spook_fish()
		Phase.TRUE_DIP:
			catch_fish()

# ─────────────────────────────────────────────────────────────────────────────
# SPAWNING
# ─────────────────────────────────────────────────────────────────────────────

func spawn_fish() -> void:
	for child in fish_container.get_children():
		child.queue_free()
	var spawn_list := [
		[Fish.FishType.COMMON,   4],
		[Fish.FishType.UNCOMMON, 2],
		[Fish.FishType.RARE,     1],
	]
	
	for entry in spawn_list:
		var type  = entry[0]
		var count = entry[1]
		for i in count:
			var fish = fish_scene.instantiate()
			fish.fish_type = type                    # set BEFORE add_child
			fish.position = Vector2(
				randf_range(-260, 260),
				randf_range(-160, 120)
			)
			fish_container.add_child(fish)           # _ready() runs here

# ─────────────────────────────────────────────────────────────────────────────
# PHASE 1 — CAST
# ─────────────────────────────────────────────────────────────────────────────

func do_cast() -> void:
	set_phase(Phase.FLOAT_LANDING)

	# Calculate float landing position from arrow angle
	var angle := cast_arrow.rotation
	var direction := Vector2(cos(angle), sin(angle))
	var landing_pos := cast_origin.global_position + direction * cast_distance

	# Show and tween float to landing position
	float_node.global_position = cast_origin.global_position
	float_node.show()
	var tween := create_tween()
	tween.tween_property(float_node, "global_position", landing_pos, 0.35)\
		 .set_ease(Tween.EASE_OUT)
	await tween.finished

	set_phase(Phase.CHECKING)
	await get_tree().create_timer(0.3).timeout
	check_for_fish(landing_pos)

func check_for_fish(landing_pos: Vector2) -> void:
	var closest_fish: Node2D = null
	var closest_dist: float = INF

	for fish in fish_container.get_children():
		if not fish.active:
			continue
		var dist = fish.global_position.distance_to(landing_pos)
		if dist < fish.attraction_radius and dist < closest_dist:
			closest_dist = dist
			closest_fish = fish

	if closest_fish:
		nearby_fish = closest_fish
		start_nibble_sequence()
	else:
		set_phase(Phase.NO_FISH)
		phase_hint.text = "No fish here..."
		await get_tree().create_timer(1.2).timeout
		end_cast()

# ─────────────────────────────────────────────────────────────────────────────
# PHASE 2 — NIBBLE SEQUENCE
# ─────────────────────────────────────────────────────────────────────────────

func start_nibble_sequence() -> void:
	set_phase(Phase.WAITING_NIBBLE)
	phase_hint.text = "Wait for it..."
	bob_float_gently()  # starts looping gentle bob

	# Random delay before false bob
	var wait_time: float = randf_range(
		nearby_fish.false_bob_delay_min,
		nearby_fish.false_bob_delay_max
	)
	await get_tree().create_timer(wait_time).timeout

	# Check phase hasn't been interrupted
	if current_phase != Phase.WAITING_NIBBLE:
		return
	do_false_bob()

func do_false_bob() -> void:
	set_phase(Phase.FALSE_BOB)
	phase_hint.text = "..."

	# Quick shallow dip
	var tween := create_tween()
	tween.tween_property(float_node, "position:y", float_node.position.y + 8, 0.12)
	tween.tween_property(float_node, "position:y", float_node.position.y, 0.12)
	await tween.finished

	if current_phase != Phase.FALSE_BOB:
		return  # player already pressed (spook_fish was called)

	# Brief pause between false bob and true dip
	await get_tree().create_timer(randf_range(0.4, 1.0)).timeout
	if current_phase != Phase.FALSE_BOB:
		return
	do_true_dip()

func do_true_dip() -> void:
	set_phase(Phase.TRUE_DIP)
	phase_hint.text = "NOW!"
	cast_time_start = Time.get_ticks_msec() / 1000.0

	# Deep dip animation
	var base_y := float_node.position.y
	var tween := create_tween()
	tween.tween_property(float_node, "position:y", base_y + 20, 0.2)

	# Wait for the bite window
	await get_tree().create_timer(nearby_fish.bite_window).timeout

	if current_phase == Phase.TRUE_DIP:
		# Player didn't press in time
		missed_fish()

# ─────────────────────────────────────────────────────────────────────────────
# OUTCOMES
# ─────────────────────────────────────────────────────────────────────────────

func catch_fish() -> void:
	var time_elapsed := (Time.get_ticks_msec() / 1000.0) - cast_time_start
	var perfect: bool = time_elapsed < nearby_fish.bite_window * 0.4

	set_phase(Phase.CAUGHT)
	nearby_fish.active = false
	nearby_fish.hide()   # or play a caught animation before hiding

	var points_earned: int = nearby_fish.points
	if perfect:
		points_earned += 1
		phase_hint.text = "PERFECT! +" + str(points_earned) + " pts"
	else:
		phase_hint.text = "Got one! +" + str(points_earned) + " pts"

	score += points_earned
	fish_caught += 1
	update_hud()

	await get_tree().create_timer(1.0).timeout
	end_cast()

func missed_fish() -> void:
	set_phase(Phase.MISSED)
	phase_hint.text = "Too slow! It got away."
	# Float bounces back up
	var tween := create_tween()
	tween.tween_property(float_node, "position:y",
						 float_node.position.y - 20, 0.15)
	await get_tree().create_timer(1.0).timeout
	end_cast()

func spook_fish() -> void:
	set_phase(Phase.SPOOKED)
	phase_hint.text = "You spooked it!"
	nearby_fish = null
	await get_tree().create_timer(1.0).timeout
	end_cast()

# ─────────────────────────────────────────────────────────────────────────────
# CAST CLEANUP
# ─────────────────────────────────────────────────────────────────────────────

func end_cast() -> void:
	float_node.hide()
	nearby_fish = null
	casts_remaining -= 1
	update_hud()

	if casts_remaining <= 0:
		show_results()
	else:
		await get_tree().create_timer(0.4).timeout
		set_phase(Phase.CAST_READY)
		phase_hint.text = "Aim and cast!"

# ─────────────────────────────────────────────────────────────────────────────
# RESULTS
# ─────────────────────────────────────────────────────────────────────────────

func calculate_money() -> int:
	var earned := 0
	for threshold in MONEY_TIERS.keys():
		if score >= threshold:
			earned = MONEY_TIERS[threshold]
	return earned

func show_results() -> void:
	set_phase(Phase.ROUND_END)
	var money := calculate_money()

	result_screen.get_node("ScoreDisplay").text = "Score: %d" % score
	result_screen.get_node("FishCaught").text   = "Fish caught: %d" % fish_caught
	result_screen.get_node("MoneyEarned").text  = "Earned: $%d" % money
	result_screen.show()

	# Emit signal so the game state can receive the money reward
	emit_signal("minigame_completed", money)

# ─────────────────────────────────────────────────────────────────────────────
# HELPERS
# ─────────────────────────────────────────────────────────────────────────────

func bob_float_gently() -> void:
	# Looping gentle bob — killed automatically when phase changes
	var base_y := float_node.position.y
	var tween := create_tween().set_loops()
	tween.tween_property(float_node, "position:y", base_y - 4, 0.6)\
		 .set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(float_node, "position:y", base_y + 4, 0.6)\
		 .set_ease(Tween.EASE_IN_OUT)
	# Store tween so set_phase() can kill it
	_active_tween = tween

var _active_tween: Tween = null

func set_phase(new_phase: Phase) -> void:
	if _active_tween:
		_active_tween.kill()
		_active_tween = null
	current_phase = new_phase

func update_hud() -> void:
	casts_label.text = "Casts left: %d" % casts_remaining
	score_label.text = "Score: %d" % score

signal minigame_completed(money_earned: int)
