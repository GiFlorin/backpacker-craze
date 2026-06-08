extends Control
@onready var text_label: RichTextLabel = $NinePatchRect/RichTextLabel
@onready var dialogue_options: Node = $dialogue_options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_chat():
	visible = true
	text_label.text = dialogue_options.choose_text()

func close_chat():
	visible = false
