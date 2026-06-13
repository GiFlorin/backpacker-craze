extends Node2D

var game = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = self.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	if !$rock_spawner.active:
		$rock_spawner.start()
	if !$bird_spawner.active:
		$bird_spawner.start()

func _on_drown_body_entered(body: Node2D) -> void:
	game.die()
