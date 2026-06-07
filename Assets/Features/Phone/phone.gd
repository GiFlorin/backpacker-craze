extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var phone_shape: Node2D = $phone_shape

var phone_active: bool = false

func _ready() -> void:
	$phone_shape/phone_area.mouse_entered.connect(_on_mouse_entered_phone)
	$phone_shape/phone_area.mouse_exited.connect(_on_mouse_exited_phone)
	phone_shape.position.y = 0

func _on_mouse_entered_phone():
	phone_active = true
	animation_player.play('phone_in')

func _on_mouse_exited_phone():
	phone_active = false
	animation_player.play_backwards("phone_in")

func _process(delta: float) -> void:
	if !phone_active:
		pass
