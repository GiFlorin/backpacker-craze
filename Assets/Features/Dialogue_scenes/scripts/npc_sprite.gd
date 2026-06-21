extends Node2D
@onready var sprite: Sprite2D = $Sprite2D

var cur_character = ''
var cur_mood = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_character(new_character:String, mood:String):
	if new_character == cur_character:
		change_mood(mood)
	else:
		if sprites_resources.has(new_character):
			if sprites_resources[new_character].has(mood):
				$"../AnimationPlayer".play("npc_fade_out")
				sprite.texture = sprites_resources[new_character][mood]
				$"../AnimationPlayer".play_backwards("npc_fade_out")
				cur_character = new_character
				cur_mood = mood
			else:
				print('%s mood invalid' % mood)
		else:
			print('%s character invalid' % new_character)

func change_mood(new_mood:String):
	if sprites_resources[cur_character].has(new_mood):
		sprite.texture = sprites_resources[cur_character][new_mood]
		cur_mood = new_mood
	else:
		print('%s mood invalid' % new_mood)

var sprites_resources: Dictionary = {
	'Marina': { # moods
		'annoyed': load("res://Assets/Features/Dialogue_scenes/assets/marina/Annoyed.png"),
		'blushing': load("res://Assets/Features/Dialogue_scenes/assets/marina/Blushing.png"),
		'dreamy': load("res://Assets/Features/Dialogue_scenes/assets/marina/Dreamy.png"),
		'embarassed': load("res://Assets/Features/Dialogue_scenes/assets/marina/Embarrassed.png"),
		'excited': load("res://Assets/Features/Dialogue_scenes/assets/marina/Excited.png"),
		'excited_blushing': load("res://Assets/Features/Dialogue_scenes/assets/marina/Excited_blushing.png"),
		'flustered': load("res://Assets/Features/Dialogue_scenes/assets/marina/Flustered.png"),
		'irritated': load("res://Assets/Features/Dialogue_scenes/assets/marina/Irritated.png"),
		'neutral': load("res://Assets/Features/Dialogue_scenes/assets/marina/Neutral.png"),
		'neutral_talking': load("res://Assets/Features/Dialogue_scenes/assets/marina/Neutral_talking.png"),
		'panicking': load("res://Assets/Features/Dialogue_scenes/assets/marina/Panicking.png"),
		'proud': load("res://Assets/Features/Dialogue_scenes/assets/marina/Proud.png"),
		'shocked': load("res://Assets/Features/Dialogue_scenes/assets/marina/Shocked.png"),
		'smile': load("res://Assets/Features/Dialogue_scenes/assets/marina/smile.png"),
		'smug': load("res://Assets/Features/Dialogue_scenes/assets/marina/smug.png"),
		'smug_blushing': load("res://Assets/Features/Dialogue_scenes/assets/marina/smug_blushing.png"),
		'worried': load("res://Assets/Features/Dialogue_scenes/assets/marina/worried.png")
	},
	'Malcolm': {
		'confident': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Confident.png"),
		'disappointed': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Disappointed.png"),
		'embarrassed': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Embarrassed.png"),
		'excited': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Excited.png"),
		'neutral': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Neutral.png"),
		'surprised': load("res://Assets/Features/Dialogue_scenes/assets/malcolm/Surprised.png")
	},
	'Malcolm_board': {
		'confident': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Confident.png"),
		'disappointed': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Disappointed.png"),
		'embarrassed': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Embarrassed.png"),
		'excited': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Excited.png"),
		'neutral': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Neutral.png"),
		'surprised': load("res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Surprised.png")
	}
}
