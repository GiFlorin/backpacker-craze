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
				sprite.texture = load(sprites_resources[new_character][mood])
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
		'annoyed': "res://Assets/Features/Dialogue_scenes/assets/marina/Annoyed.png",
		'blushing': "res://Assets/Features/Dialogue_scenes/assets/marina/Blushing.png",
		'dreamy': "res://Assets/Features/Dialogue_scenes/assets/marina/Dreamy.png",
		'embarrassed': "res://Assets/Features/Dialogue_scenes/assets/marina/Embarrassed.png",
		'excited': "res://Assets/Features/Dialogue_scenes/assets/marina/Excited.png",
		'excited_blushing': "res://Assets/Features/Dialogue_scenes/assets/marina/Excited_blushing.png",
		'flustered': "res://Assets/Features/Dialogue_scenes/assets/marina/Flustered.png",
		'irritated': "res://Assets/Features/Dialogue_scenes/assets/marina/Irritated.png",
		'neutral': "res://Assets/Features/Dialogue_scenes/assets/marina/Neutral.png",
		'neutral_talking': "res://Assets/Features/Dialogue_scenes/assets/marina/Neutral_talking.png",
		'panicking': "res://Assets/Features/Dialogue_scenes/assets/marina/Panicking.png",
		'proud': "res://Assets/Features/Dialogue_scenes/assets/marina/Proud.png",
		'shocked': "res://Assets/Features/Dialogue_scenes/assets/marina/Shocked.png",
		'smile': "res://Assets/Features/Dialogue_scenes/assets/marina/smile.png",
		'smug': "res://Assets/Features/Dialogue_scenes/assets/marina/smug.png",
		'smug_blushing': "res://Assets/Features/Dialogue_scenes/assets/marina/smug_blushing.png",
		'worried': "res://Assets/Features/Dialogue_scenes/assets/marina/worried.png"
	},
	'Malcolm': {
		'confident': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Confident.png",
		'disappointed': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Disappointed.png",
		'embarrassed': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Embarrassed.png",
		'excited': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Excited.png",
		'neutral': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Neutral.png",
		'surprised': "res://Assets/Features/Dialogue_scenes/assets/malcolm/Surprised.png"
	},
	'Malcolm_board': {
		'confident': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Confident.png",
		'disappointed': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Disappointed.png",
		'embarrassed': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Embarrassed.png",
		'excited': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Excited.png",
		'neutral': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Neutral.png",
		'surprised': "res://Assets/Features/Dialogue_scenes/assets/malcolm_board/Surprised.png"
	},
	'Conway': {
		'annoyed':"res://Assets/Features/Dialogue_scenes/assets/Conway/annoyed.png",
		'looking_left':"res://Assets/Features/Dialogue_scenes/assets/Conway/looking left.png",
		'neutral':"res://Assets/Features/Dialogue_scenes/assets/Conway/neutral.png",
		'neutral_eyes_closed':"res://Assets/Features/Dialogue_scenes/assets/Conway/neutral_eyes closed.png",
		'neutral_talking':"res://Assets/Features/Dialogue_scenes/assets/Conway/neutral_talking.png",
		'sad_smile': "res://Assets/Features/Dialogue_scenes/assets/Conway/sad smile.png",
		'sad': "res://Assets/Features/Dialogue_scenes/assets/Conway/sad.png",
		'sad_talking':"res://Assets/Features/Dialogue_scenes/assets/Conway/sad_talking.png",
		'smile': "res://Assets/Features/Dialogue_scenes/assets/Conway/smile.png",
		'talking_wink': "res://Assets/Features/Dialogue_scenes/assets/Conway/talking_wink.png",
		'wave_smile':"res://Assets/Features/Dialogue_scenes/assets/Conway/Wave_smile.png",
		'wave_talking_wink': "res://Assets/Features/Dialogue_scenes/assets/Conway/Wave_talking_wink.png",
		'wave_wink': "res://Assets/Features/Dialogue_scenes/assets/Conway/Wave_wink.png",
		'wink': "res://Assets/Features/Dialogue_scenes/assets/Conway/wink.png"
	},
	'Conway_dress': {
		'blushing': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/blushing.png",
		'blushing_nervous': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/blushing_nervous.png",
		'nervous2': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/nervous2.png",
		'nervous': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/nervous.png",
		'nervous_smile': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/nervous_smile.png",
		'neutral_talking': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/neutral_talking.png",
		'o': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/o.png",
		'playful': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/playful.png",
		'sad1': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/sad1.png",
		'sad2': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/sad2.png",
		'sad_talking': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/sad_talking.png",
		'serious': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/serious.png",
		'shocked': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/shocked.png",
		'smile_blushing': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/smile_blushing.png",
		'surprised2': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/surprised2.png",
		'surprised': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/surprised2.png",
		'surprised_blushing': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/surprised_blushing.png",
		'winking_laugh': "res://Assets/Features/Dialogue_scenes/assets/Conway_dress/winking_laugh.png"
	},
	'Priti': {
		'amused': "res://Assets/Features/Dialogue_scenes/assets/priti/amused.png",
		'amused_blushing': "res://Assets/Features/Dialogue_scenes/assets/priti/amused_blushing.png",
		'happy_laugh': "res://Assets/Features/Dialogue_scenes/assets/priti/happy_laugh.png",
		'serious': "res://Assets/Features/Dialogue_scenes/assets/priti/Serious.png",
		'shouting1': "res://Assets/Features/Dialogue_scenes/assets/priti/shouting1.png",
		'shouting2': "res://Assets/Features/Dialogue_scenes/assets/priti/shouting2.png",
		'smug1': "res://Assets/Features/Dialogue_scenes/assets/priti/smug1.png",
		'smug2_blushing': "res://Assets/Features/Dialogue_scenes/assets/priti/smug2_blushing.png",
		'smug3_eyes_closed': "res://Assets/Features/Dialogue_scenes/assets/priti/smug3_eyes closed.png",
		'smug4_blushing_eyes_closed': "res://Assets/Features/Dialogue_scenes/assets/priti/smug4_blushing_eyes closed.png",
		'thinking': "res://Assets/Features/Dialogue_scenes/assets/priti/thinking_eyes closed.png",
		'unbothered': "res://Assets/Features/Dialogue_scenes/assets/priti/unbothered.png",
		'winking_laugh': "res://Assets/Features/Dialogue_scenes/assets/priti/winking_laugh.png"
	},
	'Tora': {
		'amused': "res://Assets/Features/Dialogue_scenes/assets/tora/Amused.png",
		'black_gradient': "res://Assets/Features/Dialogue_scenes/assets/tora/Black gradient.png",
		'bored': "res://Assets/Features/Dialogue_scenes/assets/tora/Bored.png",
		'crying_of_laughter': "res://Assets/Features/Dialogue_scenes/assets/tora/crying of laughter.png",
		'disbelief': "res://Assets/Features/Dialogue_scenes/assets/tora/Disbelief_Caught Off Guard.png",
		'eek': "res://Assets/Features/Dialogue_scenes/assets/tora/eek.png",
		'extremely_panicked1': "res://Assets/Features/Dialogue_scenes/assets/tora/extremely panicked1.png",
		'extremely_panicked2': "res://Assets/Features/Dialogue_scenes/assets/tora/extremely panicked2.png",
		'laughing': "res://Assets/Features/Dialogue_scenes/assets/tora/Laughing.png",
		'nervous_tired': "res://Assets/Features/Dialogue_scenes/assets/tora/Nervous_Tired_Exhausted_Awkward.png",
		'neutral': "res://Assets/Features/Dialogue_scenes/assets/tora/Neutral.png",
		'panicking2': "res://Assets/Features/Dialogue_scenes/assets/tora/Panicking2.png",
		'panicking': "res://Assets/Features/Dialogue_scenes/assets/tora/Panicking.png",
		'proud_or_smiling': "res://Assets/Features/Dialogue_scenes/assets/tora/Proud_or_Smiling.png",
		'tired2': "res://Assets/Features/Dialogue_scenes/assets/tora/Tired2.png",
		'neutral_with_bush': "res://Assets/Features/Dialogue_scenes/assets/tora_bush/Neutral.png",
		'proud_with_bush': "res://Assets/Features/Dialogue_scenes/assets/tora_bush/Proud.png",
		'tired_awkward_with_bush': "res://Assets/Features/Dialogue_scenes/assets/tora_bush/Tired_Awkward.png"
	}
}
