extends Control

@onready var choice_box: VBoxContainer = $dialogue_box/NinePatchRect/choice_box
@onready var dialogue_box: Control = $dialogue_box
@onready var dialogues: Node2D = $dialogues
@onready var backgrounds: Node2D = $backgrounds
@onready var npc_sprite: Node2D = $npc_sprite
@onready var player_sprite: Node2D = $player_sprite

var cur_destination = ''
var cur_scene = ''
var past_speaker = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cur_destination = GameManager.cur_destination
	cur_scene = DialogueManager.cur_dialogue_scene
	dialogues.open_dialogue_file()
	choice_box.hide()
	set_dialogue_visual(dialogues.load_first()) 
	backgrounds.set_background(dialogues.get_scene_data()['background'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('Jump') and choice_box.visible == false:
		next_dialogue()

func set_dialogue_visual(data: Dictionary):
	dialogue_box.change_name_to(data['speaker'])
	past_speaker = data['speaker']
	dialogue_box.change_text_to(data['text'])
	if data['type'] == 'choices':
		dialogue_box.set_options(data['choices'])

func next_dialogue():
	var data = dialogues.advance()
	set_dialogue_visual(data)
	if data['speaker'] == "player":
		player_sprite.change_mood(data['mood'])
	elif dialogues.get_scene_data()['npcs_present'].has(data['speaker']):
		npc_sprite.update_character(data['speaker'], data['mood'])
	elif data['speaker'] == 'Narrator' or data['speaker'] == 'System':
		pass

func _on_dialogue_box_choice_made(index: int) -> void:
	$dialogue_box/NinePatchRect/choice_box.hide()
	var data = dialogues.get_cur_data()
	
	var condition = "%s_selected" % data['choices'][index]['id']
	match GameManager.cur_destination:
		GameManager.BEACH:
			dialogues.beach_conditions[condition] = true
		GameManager.LAKESIDE:
			dialogues.lakeside_conditions[condition] = true
		GameManager.JUNGLE_CITY:
			dialogues.jungle_city_conditions[condition] = true
	next_dialogue()
