extends Control

@onready var character_name: RichTextLabel = $NinePatchRect/name
@onready var text_field: RichTextLabel = $NinePatchRect/text
@onready var typewriter_timer: Timer = $NinePatchRect/typewriter_timer

var typewriter_skip = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Jump"):
		typewriter_skip = true

func change_name_to(text:String, type_vel:float=6):
	character_name.text = str(text)
	typewriter_effect(len(text), character_name, type_vel)

func change_text_to(text:String, type_vel:float=15):
	text_field.text = str(text)
	typewriter_effect(len(text), text_field, type_vel)

func typewriter_effect(len:int, node:Control, type_vel:float=15):
	var vis_char = 0
	typewriter_skip = false
	node.visible_characters = 0
	typewriter_timer.wait_time = 1/type_vel
	while vis_char < len and !typewriter_skip:
		typewriter_timer.start()
		vis_char += 1
		node.visible_characters = vis_char
		await typewriter_timer.timeout
	node.visible_characters = -1
