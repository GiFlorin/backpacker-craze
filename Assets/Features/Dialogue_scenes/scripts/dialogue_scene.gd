extends Control

@onready var choice_box: VBoxContainer = $dialogue_box/choice_box
@onready var dialogue_box: Control = $dialogue_box
@onready var dialogues: Node2D = $dialogues
@onready var backgrounds: Node2D = $backgrounds
@onready var npc_sprite: Node2D = $npc_sprite
@onready var player_sprite: Node2D = $dialogue_box/player_sprite

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
	MusicManager.play_music(dialogues.get_scene_data()['song'])
	backgrounds.set_background(dialogues.get_scene_data()['background'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('Jump'):
		if dialogue_box.advance_check():
			next_dialogue()

func set_dialogue_visual(data: Dictionary):
	$dialogue_box/NinePatchRect.visible = true
	$dialogue_box/player_sprite.show()
	
	past_speaker = data['speaker']
	if past_speaker == 'Player':
		dialogue_box.change_name_to(GameManager.player_name)
	elif past_speaker == 'Narrator':
		dialogue_box.change_name_to('')
	else:
		dialogue_box.change_name_to(past_speaker)
	
	var text = data['text']
	text = text.replace('Y/N', GameManager.player_name)
	if data['type'] == 'thought':
		text = "(%s)" % text
	dialogue_box.change_text_to(text)
	
	if data['type'] == 'choices':
		dialogue_box.set_options(data['choices'])
		
	elif data['type'] == 'mechanic':
		if data['id'] == 'name_input_player':
			dialogue_box.input_name()
			$dialogue_box/NinePatchRect.hide()
			$dialogue_box/player_sprite.hide()

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
	choice_box.hide()
	var data = dialogues.get_cur_data()
	
	var condition = "%s_selected" % data['choices'][index]['id']
	match GameManager.cur_destination:
		GameManager.BEACH:
			dialogues.beach_conditions[condition] = true
		GameManager.LAKESIDE:
			dialogues.lakeside_conditions[condition] = true
		GameManager.JUNGLE_CITY:
			dialogues.jungle_city_conditions[condition] = true
	dialogue_box.change_text_to(data['choices'][index]['consequence_text'])
