
extends KinematicBody2D

onready var stats = $Stats
var knockback = Vector2.ZERO


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackVector * 120


func _on_Stats_no_health():
	GlobalVariables.isGrassBossDead = true
	queue_free()
	
const GRAVITY = 1300
const MAX_SPEED_V = 1600
var velocity_v = 0
var acceleration_v = 0

onready var wanderController = $WanderController

enum {
	IDLE,
	WANDER,
	SHOOT,
	ATTACK
}

var state = IDLE

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
		IDLE:
			print("Idle")
			acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY*delta)
			velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
			velocity.y=velocity_v
			move_and_slide(velocity, Vector2.UP)
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
			
		WANDER:
			print("Wander")
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
				
			velocity.x = velocity_v
			move_and_slide(velocity, Vector2.UP)
		SHOOT: 
			state = pick_random_state([IDLE, WANDER])
		ATTACK:
			state = pick_random_state([IDLE, WANDER])
			
			
			
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
