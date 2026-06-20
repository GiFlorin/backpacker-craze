extends Node2D
class_name Fish

enum FishType { COMMON, UNCOMMON, RARE }

@export var fish_type: FishType = FishType.COMMON
@export var move_speed: float = 20.0
@export var attraction_radius: float = 60.0  # FIX   # how close float must land
@export var bite_window: float = 1.2          # seconds the true dip window stays open
@export var false_bob_delay_min: float = 1.5  # min wait before false bob
@export var false_bob_delay_max: float = 3.0
@export var points: int = 1

var direction: Vector2 = Vector2.RIGHT
var active: bool = true   # false once caught or spooked

func _ready() -> void:
	# Randomise starting direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	# Set properties by type
	match fish_type:
		FishType.COMMON:
			move_speed = 20.0
			attraction_radius = 70.0
			bite_window = 1.4
			points = 1
			modulate = Color(0.4, 0.6, 1.0, 0.45)
		FishType.UNCOMMON:
			move_speed = 35.0
			attraction_radius = 55.0
			bite_window = 1.0
			points = 2
			modulate = Color(0.3, 0.8, 0.5, 0.45)
		FishType.RARE:
			move_speed = 55.0
			attraction_radius = 40.0
			bite_window = 0.65
			points = 4
			modulate = Color(0.9, 0.6, 0.1, 0.5)

func _process(delta: float) -> void:
	if not active:
		return
	position += direction * move_speed * delta
	# Bounce off water zone edges (set water bounds as a constant or exported rect)
	var bounds := Rect2(-300, -200, 600, 350) # FIX
	if position.x < bounds.position.x or position.x > bounds.end.x:
		direction.x *= -1
	if position.y < bounds.position.y or position.y > bounds.end.y:
		direction.y *= -1
