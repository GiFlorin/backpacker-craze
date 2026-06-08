extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var phone_shape: Node2D = $phone_shape
@onready var map_app: TextureButton = $phone_shape/app_icons/map_app

var phone_active: bool = false
var is_hovered:bool = false

func _ready() -> void:
	$phone_shape/phone_area.mouse_entered.connect(_on_mouse_entered_phone)
	$phone_shape/phone_area.mouse_exited.connect(_on_mouse_exited_phone)
	phone_shape.position.y = 0

func _on_mouse_entered_phone():
	is_hovered = true

func _on_mouse_exited_phone():
	is_hovered = false

func _process(delta: float) -> void:
	if !phone_active and (is_hovered or map_app.is_hovered):
		animation_player.play('phone_in')
		phone_active = true
	elif phone_active and (!is_hovered and !map_app.is_hovered()):
		animation_player.play_backwards("phone_in")
		phone_active = false
