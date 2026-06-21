extends Node2D

var beachside_dialogue_path := 'res://Assets/Features/Dialogue_scenes/dialogue_files/beachside_dialogue_script.json'
@export var lakeside_dialogue: Script
@export var jungle_city_dialogue: Script

var _index = 0
var _scene_index = 0
var data: Dictionary
var cur_conditions: Dictionary
var file

# ------------- CONDITIONS -------------------
var beach_conditions = {
	'choice_A_selected' : false,
	'choice_B_selected': false,
	'choice_C_selected': false,
	'choice_D_selected': false,
	'choice_E_selected' : false,
	'choice_F_selected': false,
	'choice_G_selected': false,
	'choice_H_selected': false,
	'choice_I_selected': false
}

var lakeside_conditions = {
	
}

var jungle_city_conditions = {
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GameManager.cur_destination:
			GameManager.BEACH:
				cur_conditions = beach_conditions
				file = FileAccess.open(beachside_dialogue_path, FileAccess.READ)
			GameManager.LAKESIDE:
				cur_conditions = lakeside_conditions
			GameManager.JUNGLE_CITY:
				cur_conditions = jungle_city_conditions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_dialogue_file():
	data = JSON.parse_string(file.get_as_text())

func load_first():
	var dialogue_data = data['scenes'][0]['dialogue'][0]
	return dialogue_data

func get_cur_data():
	var dialogue_data = data['scenes'][_scene_index]['dialogue'][_index]
	return dialogue_data

func get_scene_data():
	var scene_data = data['scenes'][_scene_index]
	return scene_data

func advance():
	while true:
		if len(data['scenes'][_scene_index]['dialogue']) > _index:
			if data['scenes'][_scene_index]['dialogue'][_index]['next'] == 'end_scene':
				advance_scene()
			else: _index += 1
			var dialogue_data = data['scenes'][_scene_index]['dialogue'][_index]
			
			# if the condition is in the available conditions dict
			if dialogue_data['condition'] in cur_conditions.keys(): 
				if cur_conditions[dialogue_data['condition']] == true:
					return dialogue_data
				else:
					continue
			else:
				return dialogue_data
		else:
			print('ERROR')

func advance_scene(): # FIX
	_scene_index += 1
	_index = 0
	get_tree().paused = true
	$"../AnimationPlayer".play("scene_transition_in")
	await get_tree().create_timer(0.5).timeout
	$"../backgrounds".set_background(get_scene_data()['background'])
	$"../AnimationPlayer".play_backwards("scene_transition_in")
	get_tree().paused = false
	
	if data['scenes'][_scene_index]['dialogue'][_index]['next'] == 'end_dest':
		pass # TODO next dest
