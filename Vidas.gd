extends Control


var hearts = 4 setget set_hearts
var max_heart = 4 setget set_mex_hearts


onready var label = $Label

func set_hearts(value):
	hearts = clamp(value,0, max_heart)
	
func set_mex_hearts(value):
	max_heart = max(value,1)
	
