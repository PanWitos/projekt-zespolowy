extends Node

onready var menu = $PauseMenu
onready var world = $World

func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		if get_tree().paused:
			get_tree().paused = false
			menu.visible = false
		elif get_tree().paused == false:
			get_tree().paused = true
			menu.visible = true
			menu.rect_position = world.playerPos + Vector2(-960,-790)


func _on_Quit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	get_tree().paused = false
	menu.visible = false
