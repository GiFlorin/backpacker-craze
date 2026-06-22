extends Node2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var resource_songs = {
	'berries_and_vine': "res://Assets/Shared/music/Berries and Vine ver.6.wav",
	'boardwalk_azure': "res://Assets/Shared/music/Boardwalk Azure ver.8.wav",
	'conway_the_con_man': "res://Assets/Shared/music/Conway the Con...Man_ ver.4.wav",
	'dancing_lights': "res://Assets/Shared/music/Dancing Lights ver.5.wav",
	'lake_ryoka': "res://Assets/Shared/music/Lake Ryoka ver.9.wav"
}
var cur_track: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_music(track: String):
	if track == cur_track:
		return
	else:
		if resource_songs.keys().has(track):
			var file_path = resource_songs[track]
			audio_player.stream = load(file_path) as AudioStreamWAV
			audio_player.play()
		else:
			print("Invalid song %s" % track)
