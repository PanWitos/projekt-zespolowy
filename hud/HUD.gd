extends Control

var bar : float = 100

onready var barFull = $Control/barFull

func _ready():
	PlayerStats.connect("health_changed",self,"set_bar")
	
	
func set_bar(value):
	bar = value
	if barFull != null:
		barFull.rect_size.x = 2*bar 

func checkBar():
	if barFull.rect_size.x != PlayerStats.currHealth*2:
		set_bar(PlayerStats.currHealth)

func _process(delta):
	checkBar()
