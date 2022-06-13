extends Control

onready var info = $Panel/info

func _ready():
	SignalBus.connect("AbilityMouseOver", self, "displayText")
	
func displayText(value):
	match value:
		0:
			info.text = "Ability 0"
		1: 
			info.text = "Ability 1"
		2:
			info.text = "Ability 2"
