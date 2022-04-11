extends KinematicBody2D

const ACCELERATION = 60000
const MAX_SPEED_H = 650
const MAX_SPEED_V = 1600
const FRICTION = 80000
const GRAVITY = 1300

var velocity_h = 0
var velocity_v = 0
var velocity = Vector2.ZERO
var JUMPS = 2
var acceleration_v = 0

func numberMoveToward(from, to, delta):
	if from < to:
		if from + delta <= to:
			return from + delta
		else:
			return to
	elif from > to:
		if from - delta <= to:
			return from - delta
		else:
			return to
	else:
		 return to

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * MAX_SPEED_H
	
	if Input.is_action_just_pressed("ui_up") && JUMPS > 0:
		velocity_v = -1600
		acceleration_v = 0
		
	input_vector.y = MAX_SPEED_V
	
	acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY * delta)
	
	if input_vector.x != 0:
		velocity_h = numberMoveToward(velocity_h, input_vector.x, ACCELERATION * delta)
	else:
		velocity_h = numberMoveToward(velocity_h, 0 , ACCELERATION * delta)
	
	velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
	
	velocity.x = velocity_h
	velocity.y = velocity_v
	
	move_and_slide(velocity)
