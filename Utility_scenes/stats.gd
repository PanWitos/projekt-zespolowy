extends Node

export var maxHealth = 100
onready var currHealth = maxHealth setget setCurrHealth, getCurrHealth
export var maxCombo = 1 
export var additionalJumps = 0
export var canDive = true
export var canDash = true
export var canFireball = true

signal noHealth

func setCurrHealth(value):
	currHealth = value
	if currHealth <= 0:
		emit_signal("noHealth")

func getCurrHealth():
	return currHealth

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"maxHealth" : maxHealth,
		"currHealth" : currHealth,
		"maxCombo" : maxCombo,
		"additionalJumps" : additionalJumps,
		"canDive" : canDive,
		"canDash" : canDash,
		"canFireball" : canFireball
	}
	return save_dict
