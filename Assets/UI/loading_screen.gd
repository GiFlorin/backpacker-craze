extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
var next_scene_path = "res://Assets/Features/Dialogue_scenes/dialogue_scene.tscn"
var progress: Array[float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(next_scene_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var pct = progress[0] * 100
			progress_bar.value = pct
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(next_scene_path)
			get_tree().change_scene_to_packed(scene)
