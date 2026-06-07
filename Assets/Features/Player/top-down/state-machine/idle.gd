extends Node2D
const facing_directions_list = ['up', 'down', 'left', 'right', 'up left', 'up right', 'down left', 'down right']
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite"

var speed = 0

func set_animation(facing_direction): # retornar nome da animação
	
	match facing_direction:
		facing_directions_list[0]:
			return 'idle_back'
		facing_directions_list[1]:
			return 'idle_front'
		facing_directions_list[2]:
			return 'idle_side'
		facing_directions_list[3]:
			return 'idle_side'
		facing_directions_list[4]:
			return 'idle_up_side'
		facing_directions_list[5]:
			return 'idle_up_side'
		facing_directions_list[6]:
			return 'idle_down_side'
		facing_directions_list[7]:
			return 'idle_down_side'
