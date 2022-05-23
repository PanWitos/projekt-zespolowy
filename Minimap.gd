extends Control

onready var camera = $MapCamera

func changeCameraPos(name):
	var pos = self.get_node(name)
	camera.position = pos.position
