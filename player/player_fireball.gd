extends KinematicBody2D

const SPEED = 800

var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var hitboxPivot = $hitbox_pivot
onready var hurtboxPivot = $hurtbox_pivot 
export var flipped_h = false


func _ready():
	if(flipped_h):
		velocity.x = -SPEED
		sprite.flip_v = true
		hurtboxPivot.rotation_degrees = 180
		hitboxPivot.rotation_degrees = 180
		global_position.x -= 100
	else:
		velocity.x = SPEED
		global_position.x += 100
	
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	

func _on_hurtbox_body_entered(body):
	var PlayerFireballExplosion = load("res://player/player_fireball_explosion.tscn") 
	var playerFireballExplosion = PlayerFireballExplosion.instance()
	var world = get_tree().current_scene
	playerFireballExplosion.global_position = global_position
	world.add_child(playerFireballExplosion)
	queue_free()


func _on_hitbox_area_entered(area):
	var PlayerFireballExplosion = load("res://player/player_fireball_explosion.tscn") 
	var playerFireballExplosion = PlayerFireballExplosion.instance()
	var world = get_tree().current_scene
	playerFireballExplosion.global_position = global_position
	world.add_child(playerFireballExplosion)
	queue_free()
