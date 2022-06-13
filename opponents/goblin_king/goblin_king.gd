extends KinematicBody2D

onready var stats = $Stats
var knockback = Vector2.ZERO

const MAX_SPEED_V = 1600
const MAX_SPEED_X = 150


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackVector * 120


func _on_Stats_no_health():
	GlobalVariables.isGrassBossDead = true
	queue_free()
	
const GRAVITY = 1300
var velocity_v = 0
var acceleration_v = 0
var velocity = Vector2.ZERO
var is_moving_left = true

onready var wanderController = $WanderController

enum {
	IDLE,
	WANDER,
	SHOOT,
	ATTACK
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
			$AnimationPlayer.play("move_right")
			knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
			knockback = move_and_slide(knockback)
	
			acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY*delta)
			velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
			velocity.y=velocity_v
			velocity.x= -MAX_SPEED_X if is_moving_left else MAX_SPEED_X
			move_and_slide(velocity, Vector2.UP)
			
			detect_turn_around()
		ATTACK:
			$AnimationPlayer.play("jump")
			
			
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func detect_turn_around():
	if ($RayCastInfront.is_colliding()):
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		print("obrot")

func end_attack():
	state = WANDER

func _on_detection_body_entered(body):
	print("elo")
	state = ATTACK
 
