extends Control

@onready var character_name: RichTextLabel = $NinePatchRect/name
@onready var text_field: RichTextLabel = $NinePatchRect/text
@onready var typewriter_timer: Timer = $NinePatchRect/typewriter_timer
@onready var choice_box: VBoxContainer = $NinePatchRect/choice_box

var typewriter_skip = false
var ready_to_go = false
signal choice_made(index: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Jump"):
		typewriter_skip = true

func change_name_to(text:String, type_vel:float=6):
	character_name.text = str(text)
	typewriter_effect(len(text), character_name, type_vel)

func change_text_to(text:String, type_vel:float=15):
	text_field.text = str(text)
	ready_to_go = false
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
	if typewriter_skip and node.visible_characters == -1:
		ready_to_go = true

func set_options(options:Array):
	choice_box.visible = true
	var index := -1
	for child in choice_box.get_children():
		index += 1
		if len(options) > index:
			child.text = options[index]['text']
		else:
			child.hide()

# ------------ choice option buttons -------------
func _on_option_a_pressed() -> void:
	choice_made.emit(0)

func _on_option_b_pressed() -> void:
	choice_made.emit(1)

func _on_option_c_pressed() -> void:
	choice_made.emit(2)

func _on_option_d_pressed() -> void:
	choice_made.emit(3)
