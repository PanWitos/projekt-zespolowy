extends Node

onready var stats = $Stats
var knockback = Vector2.ZERO


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackVector * 120


func _on_Stats_no_health():
	GlobalVariables.isGrassBossDead = true
	queue_free()

	
