extends Node

var isGrassBossDead = false

var lastSaveStation = null

var list = []

func _ready():
	SignalBus.connect("worldList", self, "updateList")

func save():
	
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"isGrassBossDead" : isGrassBossDead,
		"lastSaveStation" : lastSaveStation,
		"list" : list
	}
	print("GlobalVariables save")
	return save_dict

func updateList(name):
	if name in list:
		pass
	else:
		list.append(name)
