extends Node2D

export var id = 0

var grassActionFinished = false

onready var blockade;

func _ready():
	if self.name == "1_11":
		blockade = $Blockade
		if GlobalVariables.isGrassBossDead == true:
			get_node("goblin_king").queue_free()

func _process(delta):
	if self.name == "1_11":
		if GlobalVariables.isGrassBossDead == true and grassActionFinished == false:
			print("Wygranko")
			blockade.queue_free()
			grassActionFinished = true
