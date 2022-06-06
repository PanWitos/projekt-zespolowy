extends Area2D

export var damage = 10 setget , getDamage
export var knockbackVector = Vector2(0,-1) setget , getKnockback

func getDamage():
	return damage
	
func getKnockback():
	return knockbackVector
