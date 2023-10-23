extends KinematicBody2D


const ACCELERATION = 800
const MAX_SPEED =300
const FRICTION = 500
var Velocity = Vector2.ZERO


onready var animationPlayer = $AnimationPlayer
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animationPlayer.play("Caminar")
		Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
	
		Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	Velocity =  move_and_slide(Velocity)