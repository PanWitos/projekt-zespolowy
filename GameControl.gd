extends Node

onready var menu = $CanvasLayer/PauseMenu
onready var minimap = $CanvasLayer/PauseMenu/Panel/ViewportContainer/Viewport/Minimap
onready var world = $World

func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		if get_tree().paused:
			get_tree().paused = false
			menu.visible = false
		elif get_tree().paused == false:
			get_tree().paused = true
			menu.visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	get_tree().paused = false
	menu.visible = false
	

func _on_World_cameraChange(name):
	minimap.changeCameraPos(name)
	minimap.liftMask(name)
	
