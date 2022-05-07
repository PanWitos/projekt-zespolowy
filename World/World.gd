extends Node

onready var currentLevel = self.get_child(0)

func _ready():
	SignalBus.connect("LevelChange", self, "_LevelChange")
	
	var start = currentLevel.get_node("startPoint")
	currentLevel.add_child(load("res://player/player.tscn").instance())
	var player = currentLevel.get_node("player")
	player.position = start.position

func _LevelChange(code):
	var nextLevel
	var player
	var spawn
	var nextLevelCode
	var spawnCode
	
	nextLevelCode = code.substr(0,4)
	spawnCode = code[4]
	print(spawnCode)
	nextLevel = load("res://World/" + nextLevelCode + ".tscn").instance()
	add_child(nextLevel)
	spawn = nextLevel.get_node(str(spawnCode))
	nextLevel.add_child(load("res://player/player.tscn").instance())
	player = nextLevel.get_node("player")
	player.position = spawn.position
	
	currentLevel.queue_free()
	currentLevel = nextLevel