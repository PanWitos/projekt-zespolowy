extends KinematicBody2D

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	print(health)


func _on_hurtbox_area_entered(area):
	health -= 10
