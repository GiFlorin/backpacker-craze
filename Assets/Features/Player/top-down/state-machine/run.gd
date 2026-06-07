extends Node2D
const facing_directions_list = ['up', 'down', 'left', 'right', 'up left', 'up right', 'down left', 'down right']
var speed = 900
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite"


func set_animation(facing_direction): # retornar nome da animação
	match facing_direction:
		facing_directions_list[0]:
			return 'run_up'
		facing_directions_list[1]:
			return 'run_down'
		facing_directions_list[2]:
			return 'run_side'
		facing_directions_list[3]:
			return 'run_side'
		facing_directions_list[4]:
			return 'run_up_side'
		facing_directions_list[5]:
			return 'run_up_side'
		facing_directions_list[6]:
			return 'run_down_side'
		facing_directions_list[7]:
			return 'run_down_side'
