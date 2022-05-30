extends StaticBody2D

var player = null


func _on_Area2D_body_entered(body):
	player = body;
	print("Wszedl")


func _on_Area2D_body_exited(body):
	player = null;
	print("Wyszedl")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_end") and player != null:
		print("chuj")
