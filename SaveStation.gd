extends StaticBody2D

var player = null
export var id = ""

func _process(delta):
	if player != null:
		if Input.is_action_just_pressed("ui_accept"):
			save_game()
			print("save")

func _on_Area2D_body_entered(body):
	player = body


func _on_Area2D_body_exited(body):
	player = null
	
func save_game():
	GlobalVariables.lastSaveStation = id
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var node_data = PlayerStats.save()
	save_game.store_line(to_json(node_data))
	node_data = GlobalVariables.save()
	save_game.store_line(to_json(node_data))
	save_game.close()
