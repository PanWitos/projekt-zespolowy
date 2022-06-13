extends Node

onready var currentLevel = self.get_child(0)

export var playerPos = Vector2.ZERO

signal cameraChange


func _ready():
	SignalBus.connect("LevelChange", self, "_LevelChange")
	if GlobalVariables.lastSaveStation != null:
		var newLevelCode = GlobalVariables.lastSaveStation.substr(0,4)
		var newLevel = load("res://World/" + GlobalVariables.lastSaveStation[0] + "/" + newLevelCode + ".tscn").instance()
		call_deferred("add_child", newLevel)
		currentLevel.queue_free()
		currentLevel = newLevel
	var start = currentLevel.get_node("startPoint")
	currentLevel.add_child(load("res://player/player.tscn").instance())
	var player = currentLevel.get_node("player")
	player.position = start.position
	
	

func _LevelChange(code):
	
	var nextLevel
	var player
	var playerIns
	var spawn
	var worldCode
	var nextLevelCode
	var spawnCode
	
	worldCode = code[0]
	nextLevelCode = code.substr(0,4)
	spawnCode = code[5]
	nextLevel = load("res://World/" + worldCode + "/" + nextLevelCode + ".tscn").instance()
	call_deferred("add_child", nextLevel)
	spawn = nextLevel.get_node(str(spawnCode))
	playerIns = load("res://player/player.tscn").instance()
	nextLevel.add_child(playerIns)
	player = nextLevel.get_node("player")
	player.position = spawn.position
	currentLevel.queue_free()
	currentLevel = nextLevel
	
func _process(delta):
	var player = currentLevel.get_node("player")
	playerPos = player.position
	emit_signal("cameraChange", currentLevel.name)
	SignalBus.emit_signal("worldList", currentLevel.name)
