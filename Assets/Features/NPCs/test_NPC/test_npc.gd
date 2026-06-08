extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var interactable_icon: ColorRect = $interactable_icon

const speed = 300
var cur_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var is_roaming: bool = true
var is_chatting: bool = false

var player
var player_in_chat_zone

var dialogue_scene_pending = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	interactable_icon.visible = false

func _process(delta):
	if dialogue_scene_pending:
		$important_icon.visible = true
	else: 
		$important_icon.visible = false
	if cur_state == 0 or cur_state == 1:
		animated_sprite.play("idle_front")
		animated_sprite.flip_h = false
	elif cur_state == 2 and !is_chatting:
		if dir.x == -1:
			animated_sprite.play("walk_side")
			animated_sprite.flip_h = true
		elif dir.x == 1:
			animated_sprite.play("walk_side")
			animated_sprite.flip_h = false
		
		if dir.y == -1:
			animated_sprite.play("walk_up")
			animated_sprite.flip_h = false
		elif dir.y == 1:
			animated_sprite.play("walk_down")
			animated_sprite.flip_h = false
	
	if is_roaming:
		match cur_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
	
	if Input.is_action_just_pressed("Interaction") and player_in_chat_zone:
		$Dialogue.open_chat()
		interactable_icon.visible = false
		is_roaming = false
		is_chatting = true
		animated_sprite.play("idle_front")

func choose(array: Array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * speed * delta


func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_chat_zone = true
		interactable_icon.visible = true

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_chat_zone = false
		$Dialogue.close_chat()
		interactable_icon.visible = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	cur_state = choose([IDLE, NEW_DIR, MOVE])
