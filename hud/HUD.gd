extends Control

var bar = 100

onready var barFull = $barFull

func _ready():
	PlayerStats.connect("health_changed",self,"set_bar")
	print(PlayerStats.is_connected("health_changed",self,"set_bar"))
	
func set_bar(value):
	print("eo")
	bar = value
	if barFull != null:
		barFull.rect_size.x = barFull.rect_size.x * (value/100)
	
