extends Control

@export var beachside_texts:GDScript
@export var lakeside_texts:GDScript
@export var jungle_town_texts:GDScript

@onready var dialogue_box: Control = $dialogue_box

const sprites_resources: Dictionary = {
	'player': { # moods
		'neutral':'resource',
		'happy': 'resource',
		'mad': 'resource'
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_box.change_name_to('bob')
	dialogue_box.change_text_to('jdnvoibidjhvabodfvjndsovhu abidv kdvnjpaivnpbiabfipvadnjfipvadnipbdanf')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
