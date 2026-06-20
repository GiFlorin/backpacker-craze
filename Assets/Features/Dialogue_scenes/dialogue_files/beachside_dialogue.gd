extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var dialogue := [
	{ # scene 1
		'background' :  load(""),
		'npc': '',
		'conversation' : [
			{
				'speaker': 'narrator',
				'type': 'dialogue',
				'player_mood': 'normal',
				'npc_mood': 'happy',
				'text': 'The player just arrived'
			},
			{
				'speaker': '',
				'type': 'dialogue',
				'player_mood': '',
				'npc_mood': '',
				'text': ''
			}
		]
	},
	
	{ # scene 2
		
	},
	
	{ # scene 3
		
	},
	
	{ # scene 4
		
	},
	{ # scene 5
		
	}
]
