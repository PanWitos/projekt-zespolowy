extends Control

onready var info = $Panel/info

func _ready():
	SignalBus.connect("AbilityMouseOver", self, "displayText")
	
func displayText(value):
	match value:
		0:
			info.text = "\nDouble jump:\n- while mid-air,\npress the jump button\nto jump again"
		1: 
			info.text = "Stomp:\n- while mid-air, \npress C to rapidly\nhit the ground\n- can be used to break unstable ground"
		2:
			info.text = "Fireball:\n- press V to use\n- deals damage to enemies\n- can be used to melt\nice barriers"
		3:
			info.text = "\nFire resist:\n- press ? to use\n- become briefly invulnerable to lava"
		4:
			info.text = "Dash:\n- press Z to use\n- charge in your current direction\n- can be used mid-air"
		5:
			info.text = "\nHealing:\n- press ? to use\n- regain some lost health"
