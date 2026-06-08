extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite"
@onready var idle: Node2D = $idle
@onready var walk: Node2D = $walk
@onready var run: Node2D = $run
var player
var cur_animation = 'idle_front'

var is_walking:bool = false
const facing_directions_list = ['up', 'down', 'left', 'right', 'up left', 'up right', 'down left', 'down right']
var facing_direction: String = 'down'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = self.get_parent()

func set_facing_direction():
	var direction_axis = [Input.get_axis("Left", "Right"), Input.get_axis("Down", "Up")]
	if direction_axis[0] != 0 or direction_axis[1] != 0: # if in movement
		is_walking = true
		# UP
		if direction_axis[1] > 0: # going up
			if direction_axis[0] < 0: # going left up
				facing_direction = facing_directions_list[4]
			elif direction_axis[0] > 0: # going right up
				facing_direction = facing_directions_list[5]
			else: # just up
				facing_direction = facing_directions_list[0]
		
		# DOWN
		elif direction_axis[1] < 0: # going down
			if direction_axis[0] < 0: # going left down
				facing_direction = facing_directions_list[6]
			elif direction_axis[0] > 0: # going right down
				facing_direction = facing_directions_list[7]
			else: # just down
				facing_direction = facing_directions_list[1]
		
		# SIDES
		elif direction_axis[0] < 0: # going left
			facing_direction = facing_directions_list[2]
		elif direction_axis[0] > 0: # going right
			facing_direction = facing_directions_list[3]
		
	# IDLE
	else: # idle
		is_walking = false

func process_state():
	if facing_direction == 'left' or facing_direction == 'up left' or facing_direction == 'down left':
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	if Input.is_action_pressed("Run") and is_walking: # RUNNING
		player.speed = run.speed
		return run.set_animation(facing_direction)
	elif is_walking: # WALKING
		player.speed = walk.speed
		return walk.set_animation(facing_direction)
	else: # IDLE
		return idle.set_animation(facing_direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_facing_direction()
	cur_animation = process_state()
	animated_sprite.play(cur_animation)
