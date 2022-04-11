extends KinematicBody2D

const ACCELERATION = 60000
const MAX_SPEED_H = 650
const MAX_SPEED_V = 1600
const FRICTION = 80000
const GRAVITY = 1300
const JUMP_SPEED = -1600

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite

var velocity_h = 0
var velocity_v = 0
var velocity = Vector2.ZERO
var ADDITIONAL_JUMPS = 0
var JUMPS_LEFT = 0
var acceleration_v = 0

func _ready():
	animation_player.play("Idle")

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
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	var input_vector = Vector2.ZERO
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * MAX_SPEED_H
	
	if is_on_floor():
		JUMPS_LEFT = ADDITIONAL_JUMPS
		if Input.is_action_just_pressed("ui_up"):
			velocity_v = JUMP_SPEED
			acceleration_v = 0
	else:
		if Input.is_action_just_pressed("ui_up") && JUMPS_LEFT > 0:
			velocity_v = JUMP_SPEED
			acceleration_v = 0
			JUMPS_LEFT -= 1
		
	input_vector.y = MAX_SPEED_V
	
	acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY * delta)
	
	if input_vector.x != 0:
		velocity_h = numberMoveToward(velocity_h, input_vector.x, ACCELERATION * delta)
	else:
		velocity_h = numberMoveToward(velocity_h, 0 , ACCELERATION * delta)
	
	velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
	
	velocity.x = velocity_h
	velocity.y = velocity_v
	
	move_and_slide(velocity, Vector2.UP)
