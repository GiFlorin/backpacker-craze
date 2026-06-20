extends Control

@onready var choice_box: VBoxContainer = $dialogue_box/NinePatchRect/choice_box
@onready var dialogue_box: Control = $dialogue_box

var cur_destination = ''
var cur_scene = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cur_destination = GameManager.cur_destination
	cur_scene = DialogueManager.cur_dialogue_scene
	dialogue_box.change_name_to('bob')
	dialogue_box.change_text_to('jdnvoibidjhvabodfvjndsovhu abidv kdvnjpaivnpbiabfipvadnjfipvadnipbdanf')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_dialogue_box():
	
