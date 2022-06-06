extends Control

onready var info = $Panel/info

func _ready():
	SignalBus.connect("AbilityMouseOver", self, "displayText")
	
func displayText(value):
	match value:
		0:
			info.text = "siema eniu"
		1: 
			info.text = "fajny wehikuł"
