extends Node2D

const destinations: Dictionary = {'destination 1':'res://Assets/Features/Destinations/Cities/city_1.tscn', 
'destination 2': 'res://Assets/Features/Destinations/Cities/city_2.tscn', 
'destination 3': 'res://Assets/Features/Destinations/Cities/city_3.tscn'}
var money: int = 0
var happiness: int = 0
var cur_destination = ''
var previous_scene: String = ""
var player_position: Vector2 = Vector2.ZERO

# NPC relationship levels 0-3
var test_npc_rel: int = 0

# jobs and tasks complete
