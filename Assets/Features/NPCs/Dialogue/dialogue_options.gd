extends Node

var texts = ["Hello!!",
	"Good Morning!",
	"How are you?"
]

func choose_text():
	texts.shuffle()
	return texts.front()
