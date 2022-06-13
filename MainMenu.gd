extends Control

func loadGame():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return

	save_game.open("user://savegame.save", File.READ)
	var node_data = parse_json(save_game.get_line())
	
	PlayerStats.additionalJumps = node_data.get("additionalJumps")
	PlayerStats.canDash = node_data.get("canDash")
	PlayerStats.canDive = node_data.get("canDive")
	PlayerStats.canFireball = node_data.get("canFireball")
	PlayerStats.currHealth = node_data.get("currHealth")
	PlayerStats.maxCombo = node_data.get("maxCombo")
	PlayerStats.maxHealth = node_data.get("maxHealth")
	
	node_data = parse_json(save_game.get_line())
	
	GlobalVariables.isGrassBossDead = node_data.get("isGrassBossDead")
	GlobalVariables.lastSaveStation = node_data.get("lastSaveStation")
	GlobalVariables.list = node_data.get("list")

	save_game.close()
	
	get_tree().change_scene("res://GameControl.tscn")
	


func _on_New_pressed():
	get_tree().change_scene("res://GameControl.tscn")


func _on_Load_pressed():
	loadGame()


func _on_Quit_pressed():
	get_tree().quit()
