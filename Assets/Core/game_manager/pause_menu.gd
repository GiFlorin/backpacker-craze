extends Node2D
@onready var menu: CanvasLayer = $menu

var active = false
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	request_ready()

func _ready() -> void:
	menu.visible = false
	is_paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and !is_paused and Input.is_action_just_pressed("Pause"):
		menu.visible = true
		is_paused = true
		get_tree().paused = true

func _on_button_pressed() -> void:
	if active and is_paused:
		get_tree().paused = false
		menu.visible = false
		is_paused = false
