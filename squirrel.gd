extends KinematicBody2D
const GRAVITY = 1300
const MAX_SPEED_V = 1600
var velocity_v = 0
var acceleration_v = 0
var velocity = Vector2.ZERO

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
	acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY*delta)
	velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
	velocity.y=velocity_v
	move_and_slide(velocity, Vector2.UP)

