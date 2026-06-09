extends Node2D
@onready var dest_1: TextureButton = $Dest1
@onready var dest_2: TextureButton = $Dest2
@onready var dest_3: TextureButton = $Dest3
@onready var home: TextureButton = $Home
@onready var player: Sprite2D = $"../Player"

var moving = false
var move_node
var dist = 100

func _enter_tree() -> void:
	await get_tree().process_frame 
	paint_map(GameManager.cur_destination)
	move_node = GameManager.cur_destination
	place_player()

func _on_dest_1_pressed() -> void:
	paint_map(GameManager.BEACH)
	move_node = GameManager.BEACH
	moving = true

func _on_dest_2_pressed() -> void:
	pass # Replace with function body.

func _on_dest_3_pressed() -> void:
	paint_map(GameManager.LAKESIDE)
	move_node = GameManager.LAKESIDE
	moving = true

func _on_home_pressed() -> void:
	pass # Replace with function body.

func get_dest_node(dest):
	match dest:
		GameManager.BEACH:
			return dest_1
		GameManager.LAKESIDE:
			return dest_3
		_:
			pass

func change_scene(place):
	match place:
		GameManager.BEACH:
			SceneTransition.change_scene("res://Assets/Features/Destinations/Cities/city_beach.tscn", "clouds")
		GameManager.LAKESIDE:
			SceneTransition.change_scene("res://Assets/Features/Destinations/Cities/city_lakeside.tscn", "clouds")
		_:
			pass

func paint_map(new_loc):
	reset_colors()
	get_dest_node(GameManager.cur_destination).modulate = Color(0.459, 0.711, 0.144, 1.0)

func reset_colors() -> void:
	for child in self.get_children():
		child.modulate = Color(1.0, 1.0, 1.0, 1.0)

func place_player():
	player.position = get_dest_node(GameManager.cur_destination).position

func move_player(dest) -> void:
	if moving:
		var dest_node = get_dest_node(dest)
		var speed = 6
		if dist > 6:
			var delta_y = player.position.y - dest_node.position.y
			var delta_x = player.position.x - dest_node.position.x
			var m = delta_y/delta_x
			dist = sqrt(delta_y**2 + delta_x**2)
			player.position.x -= (delta_x/abs(delta_x)) * speed
			player.position.y += (delta_y/abs(delta_y)) * m * speed
		else:
			moving = false
			change_scene(move_node)

func _process(delta: float) -> void:
	move_player(move_node)
