extends Node2D
@onready var sprite: Sprite2D = $Sprite2D

var cur_mood = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_mood(new_mood: String):
	if sprites_resources.has(new_mood):
		sprite.texture = sprites_resources[new_mood]
		cur_mood = new_mood
	else:
		print('Player sprite (%s) invalid' % new_mood)

var sprites_resources = {
	'amused': load("res://Assets/Features/Dialogue_scenes/assets/MC/Amused.png"),
	'annoyed': load("res://Assets/Features/Dialogue_scenes/assets/MC/Annoyed.png"),
	'concerned': load("res://Assets/Features/Dialogue_scenes/assets/MC/Concerned.png"),
	'confused': load("res://Assets/Features/Dialogue_scenes/assets/MC/Confused.png"),
	'crying_of_laughter': load("res://Assets/Features/Dialogue_scenes/assets/MC/crying of laughter.png"),
	'emphathizing': load("res://Assets/Features/Dialogue_scenes/assets/MC/empathizing.png"),
	'excited': load("res://Assets/Features/Dialogue_scenes/assets/MC/Excited.png"),
	'flustered': load("res://Assets/Features/Dialogue_scenes/assets/MC/Flustered (trying to hide it).png"),
	'laughing': load("res://Assets/Features/Dialogue_scenes/assets/MC/Laughing.png"),
	'nervous': load("res://Assets/Features/Dialogue_scenes/assets/MC/Nervous_Embarrassed.png"),
	'neutral': load("res://Assets/Features/Dialogue_scenes/assets/MC/Neutral.png"),
	'panicking': load("res://Assets/Features/Dialogue_scenes/assets/MC/Panicking.png"),
	'shocked': load("res://Assets/Features/Dialogue_scenes/assets/MC/Shocked.png"),
	'smile': load("res://Assets/Features/Dialogue_scenes/assets/MC/Smile.png"),
	'smile_blushing': load("res://Assets/Features/Dialogue_scenes/assets/MC/Smile_blushing.png"),
	'suspicious': load("res://Assets/Features/Dialogue_scenes/assets/MC/Suspicious.png"),
	'tired': load("res://Assets/Features/Dialogue_scenes/assets/MC/Tired.png"),
	'unimpressed': load("res://Assets/Features/Dialogue_scenes/assets/MC/Unimpressed.png")
}
