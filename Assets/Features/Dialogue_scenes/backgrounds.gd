extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

var bg_resources = {
	'beachside': {
		'A': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Beachside/Scene 1&4 - Beachside.png"),
		'B': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Beachside/Scene 2 - Beachside Tour.png"),
		'C': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Beachside/Scene 3 - Bet (encounter with surfer dude).png"),
		'D': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Beachside/Scene 5 - Restaurant.png")
	},
	'lakeside': {
		'A': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Lakeside/Scene 1 - Encounter with “tour guide”.png"),
		'B': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Lakeside/Scene 2 - hot spring.png"),
		'C': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Lakeside/Scene 3 - fishing.png")
	},
	'jungle_town': {
		'A': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Jungle Town/Scene 1 - arriving at the jungle town.png"),
		'B': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Jungle Town/Scene 2 - Cave exploration.png"),
		'C': load("res://Assets/Features/Dialogue_scenes/assets/bgs/Jungle Town/Scene 3 - lantern festival.png")
	}
}

var dest = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GameManager.cur_destination:
		GameManager.BEACH:
			dest = 'beachside'
		GameManager.LAKESIDE:
			dest = 'lakeside'
		GameManager.JUNGLE_CITY:
			dest = 'jungle_town'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_background(bg: String):
	sprite.texture = bg_resources[dest][bg]
