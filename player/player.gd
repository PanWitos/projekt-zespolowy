extends KinematicBody2D

const ACCELERATION = 4000
const MAX_SPEED_H = 650
const MAX_SPEED_V = 1600
const FRICTION = 5000
const GRAVITY = 1300
const JUMP_SPEED = -1600
const DASH_LEN = 500
const DASH_TIME = 0.1
const ATTACK_COOLDOWN = 0.8
const COMBO_PERIOD = 0.5

enum {
	NORMAL,
	DASH
}

var state = NORMAL

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitboxPivot = $SwordHitboxPivot
onready var combo_timer = $ComboTimer
onready var attack_cooldown_timer = $AttackCooldownTimer
onready var dash_timer = $DashTimer

var velocity_h = 0
var velocity_v = 0
var velocity = Vector2.ZERO
export var ADDITIONAL_JUMPS = 1
var JUMPS_LEFT = 0
var acceleration_v = 0
var dash_velocity = Vector2(DASH_LEN/DASH_TIME, 0)
var player_inverted = false
var can_attack = true
export var MAX_ATTACKS = 3


func _ready():
	combo_timer.wait_time = COMBO_PERIOD
	combo_timer.one_shot = true
	attack_cooldown_timer.wait_time = ATTACK_COOLDOWN
	attack_cooldown_timer.one_shot = true
	dash_timer.wait_time = DASH_TIME
	dash_timer.one_shot = true
	

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

func oppositeSigns(x, y):
	var product = x*y
	return (product<0)
	
func startComboTimer():
	combo_timer.start()
	
func _physics_process(delta):
	
	match state:
		NORMAL:
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
			
			if is_on_ceiling():
				acceleration_v = 0
				velocity_v = 0
			
			acceleration_v = numberMoveToward(acceleration_v, MAX_SPEED_V, GRAVITY * delta)
			
			if input_vector.x != 0:
				if oppositeSigns(input_vector.x, velocity_h):
					velocity_h = numberMoveToward(velocity_h, input_vector.x, (ACCELERATION + FRICTION) * delta)
				else:
					velocity_h = numberMoveToward(velocity_h, input_vector.x, ACCELERATION * delta)
				if velocity_h > 0:
					player_inverted = false
					swordHitboxPivot.rotation_degrees = 0
				elif velocity_h < 0:
					player_inverted = true
					swordHitboxPivot.rotation_degrees = 180
				animationState.travel("Run")
			else:
				velocity_h = numberMoveToward(velocity_h, 0 , FRICTION * delta)
				if velocity_h == 0:
					animationState.travel("Idle")
			
			velocity_v = numberMoveToward(velocity_v, MAX_SPEED_V, acceleration_v)
			
			if velocity_v > 0 && !is_on_floor():
				animationState.travel("Fall")
				
			if velocity_v < 0:
				animationState.travel("Jump")
			
			if Input.is_action_just_pressed("Attack") and can_attack:
				animationState.travel("Attack")
				
			if Input.is_action_just_pressed("Dash"):
				state = DASH
				dash_timer.start()
			
			sprite.flip_h = player_inverted
			
			velocity.x = velocity_h
			velocity.y = velocity_v
	
			move_and_slide(velocity, Vector2.UP)
		DASH:
			swordHitboxPivot.get_child(0).get_child(0).disabled = true;
			if is_on_wall() :
				state = NORMAL
			else:
				if player_inverted:
					move_and_slide(-dash_velocity, Vector2.UP)
				else:
					move_and_slide(dash_velocity, Vector2.UP)
	


func _on_ComboTimer_timeout():
	can_attack = false
	attack_cooldown_timer.start()


func _on_AttackCooldownTimer_timeout():
	can_attack = true


func _on_DashTimer_timeout():
	state = NORMAL
