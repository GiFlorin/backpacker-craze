extends Node2D
@onready var icon: Sprite2D = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var jungle_village_spr: Sprite2D = $drawings/JungleVillage
@onready var lakeside_spr: Sprite2D = $drawings/Lakeside
@onready var beachside_spr: Sprite2D = $drawings/Seaside
@onready var continue_lbl: Label = $continue_lbl

var next_scene_path := "res://Assets/Features/Dialogue_scenes/dialogue_scene.tscn"
var ready_to_go = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ready_to_go = false
	continue_lbl.hide()
	set_up_drawings()
	match GameManager.cur_destination:
		GameManager.START:
			icon.position = $markers/beach_marker.position
			animation_player.play("RESET")
			GameManager.cur_destination = GameManager.BEACH
			next_scene_path = "res://Assets/UI/loading_screen.tscn"
		GameManager.BEACH:
			icon.position = $markers/beach_marker.position
			animation_player.play("beach_lake")
			GameManager.cur_destination = GameManager.LAKESIDE
		GameManager.LAKESIDE:
			icon.position = $markers/lake_marker.position
			animation_player.play("lake_jungle")
			GameManager.cur_destination = GameManager.JUNGLE_CITY
		GameManager.JUNGLE_CITY:
			icon.position = $markers/jungle_marker.position
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	ready_to_go = true
	continue_lbl.show()

func _enter_tree() -> void:
	request_ready()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Jump") and ready_to_go:
		SceneTransition.change_scene(next_scene_path, 'clouds')

func set_up_drawings():
	for child in $drawings.get_children():
		child.hide()
		
	match GameManager.cur_destination:
		GameManager.START:
			pass
		GameManager.BEACH:
			beachside_spr.show()
		GameManager.LAKESIDE:
			beachside_spr.show()
			lakeside_spr.show()
		GameManager.JUNGLE_CITY:
			beachside_spr.show()
			lakeside_spr.show()
			jungle_village_spr.show()
