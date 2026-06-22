extends Node2D
@onready var icon: Sprite2D = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GameManager.cur_destination:
		GameManager.BEACH:
			icon.position = $markers/beach_marker.position
			animation_player.play("beach_lake")
		GameManager.LAKESIDE:
			icon.position = $markers/lake_marker.position
			animation_player.play("lake_jungle")
		GameManager.JUNGLE_CITY:
			icon.position = $markers/jungle_marker.position

func _enter_tree() -> void:
	request_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
