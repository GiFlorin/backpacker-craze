extends CharacterBody2D

@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var coyote_timer_activated: bool = false
var ledge_hop_used: bool = false
var is_jumping: bool = false

# vertical movement
const jump_height: float = -630.0
var gravity : float = 20
const max_gravity:float = 40

# horizontal movement
const max_speed: float = 280
const acceleration: float = 28
const friction: float = 5

func _physics_process(delta: float) -> void:
	var x_input: float = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var velocity_weight: float = delta * (acceleration if x_input else friction)
	velocity.x = lerp(velocity.x, x_input * max_speed, velocity_weight)
	
	if is_on_floor():
		if velocity.y >= 0:
			is_jumping = false
			coyote_timer_activated = false
			ledge_hop_used = false
			gravity = lerp(gravity, 12.0, 12.0 * delta)
	else:
		if coyote_timer.is_stopped() and !coyote_timer_activated:
			coyote_timer.start()
			coyote_timer_activated = true # ja foi usado
			
		gravity = lerp(gravity, max_gravity, 12.0 * delta)
		
	if Input.is_action_just_pressed("Up"):
		if jump_buffer_timer.is_stopped():
			jump_buffer_timer.start()
	
	if !jump_buffer_timer.is_stopped() and !is_jumping and (!coyote_timer.is_stopped() or is_on_floor()):
		velocity.y = jump_height
		is_jumping = true
		jump_buffer_timer.stop()
		coyote_timer.stop()
		coyote_timer_activated = true
	
	if is_jumping and velocity.y < 0 and !Input.is_action_pressed("Up"):
		velocity.y += 100
		print(velocity.y)
	
	if velocity.y < jump_height/2.0:
		var head_collision: Array = [$LeftHeadNudge.is_colliding(), $LeftHeadNudge2.is_colliding(), $RightHeadNudge.is_colliding(), $RightHeadNudge2.is_colliding()]
		if head_collision.count(true) == 1: # if only one head nudge is hitting the ceiling
			if head_collision[0]:
				global_position.x += 1.75 #
			if head_collision[2]:
				global_position.x -= 1.75 #
			
	if !ledge_hop_used and velocity.y > -60 and velocity.y < -10 and abs(velocity.x) > 6:
		if $Left_LedgeHop.is_colliding() and !$Left_LedgeHop2.is_colliding() and velocity.x < 0:
			velocity.y += jump_height/3.25
			ledge_hop_used = true
		if $Right_LedgeHop.is_colliding() and !$Right_LedgeHop2.is_colliding() and velocity.x > 0:
			velocity.y += jump_height/3.25
			ledge_hop_used = true
	
	velocity.y += gravity
	
	move_and_slide()
