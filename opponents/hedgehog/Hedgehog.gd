extends KinematicBody2D
const DeathEffect = preload("res://VFX/HedgehogDeathEffect.tscn")
const GRAVITY = 1300
const MAX_SPEED_V = 1600
const MAX_SPEED_X = 150
var velocity_v = 0
var acceleration_v = 0
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var is_moving_left = true
onready var stats = $Stats
onready var wanderController = $WanderController
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var floorRayCast = $RayCastFloor
onready var infrontRayCast = $RayCastInfront

enum {
	CHASE
	WANDER
}

var state = WANDER

func numberMoveToward(from, to, delta):
	
	delta = abs(delta)
	
	if from == to:
		return to
	
	if from < to:
		if from + delta < to:
			return from + delta
		else:
			return to
	elif from > to:
		if from - delta > to:
			return from - delta
		else:
			return to

func _physics_process(delta):
	
	match state:
		WANDER:
			knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
			knockback = move_and_slide(knockback)
			
			acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY*delta)
			velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
			velocity.y=velocity_v
			velocity.x= -MAX_SPEED_X if is_moving_left else MAX_SPEED_X
			move_and_slide(velocity, Vector2.UP)
			
			detect_turn_around()
			
			seek_player()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				if player.global_position.x < global_position.x:
					velocity.x= -MAX_SPEED_X
					is_moving_left = true
					infrontRayCast.cast_to.y = 50
					floorRayCast.position.x = -43
						
				else:
					velocity.x= MAX_SPEED_X
					is_moving_left = false
					infrontRayCast.cast_to.y = -50
					floorRayCast.position.x = 43
			
			else:
				state = WANDER
			
			sprite.flip_h = !is_moving_left
			move_and_slide(velocity, Vector2.UP)
			
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
func create_death_effect():
	var deathEffect = DeathEffect.instance()
	var world = get_tree().current_scene
	world.add_child(deathEffect)
	deathEffect.global_position = global_position
	
func _on_hurtbox_area_entered(area):	
	stats.health -= area.damage
	knockback = area.knockbackVector * 120

func _on_Stats_no_health():
	create_death_effect()
	queue_free()
 
func detect_turn_around():
	if ($RayCastInfront.is_colliding() and is_on_floor()):
		is_moving_left = !is_moving_left
		sprite.flip_h = !is_moving_left
		infrontRayCast.cast_to.y = -infrontRayCast.cast_to.y
		floorRayCast.position.x = -floorRayCast.position.x
		print("sonic obrot")
		
		
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
