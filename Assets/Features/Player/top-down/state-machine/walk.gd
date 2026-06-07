extends Node2D
const facing_directions_list = ['up', 'down', 'left', 'right', 'up left', 'up right', 'down left', 'down right']
var speed = 600
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite"

func set_animation(facing_direction): # retornar nome da animação
	match facing_direction:
		facing_directions_list[0]:
			return 'walk_up'
		facing_directions_list[1]:
			return 'walk_down'
		facing_directions_list[2]:
			return 'walk_side'
		facing_directions_list[3]:
			return 'walk_side'
		facing_directions_list[4]:
			return 'walk_up_side'
		facing_directions_list[5]:
			return 'walk_up_side'
		facing_directions_list[6]:
			return 'walk_down_side'
		facing_directions_list[7]:
			return 'walk_down_side'
