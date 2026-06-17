extends RigidBody2D

var motion = Vector2(-10, 0)
var game 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	motion.x = randf_range(-7, -10)
	game = self.get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	gravity_scale = 0
	move_and_collide(motion)
