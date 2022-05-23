extends Control

onready var camera = $MapCamera
onready var mask = $Mask
onready var position = $Position

func changeCameraPos(name):
	var pos = position.get_node(name)
	camera.position = pos.position

func liftMask(name):
	var tile = mask.get_node(name)
	tile.visible = false
