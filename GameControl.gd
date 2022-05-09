extends Node


func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		if get_tree().paused:
			get_tree().paused = false
		elif get_tree().paused == false:
			get_tree().paused = true
