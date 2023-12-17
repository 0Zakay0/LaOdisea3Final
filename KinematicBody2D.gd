extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 300
const FRICTION = 500
var Velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
var isAttacking = false
var wasAttackButtonPressed = false  # Nueva variable para rastrear la tecla de ataque en el fotograma anterior

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	# Verificar si la tecla de ataque fue presionada en el fotograma actual y no en el fotograma anterior
	if Input.is_action_pressed("ui_accept") and not wasAttackButtonPressed:
		isAttacking = true
		animationPlayer.play("Atacar")
		Velocity = Vector2.ZERO 

	if isAttacking and animationPlayer.is_playing():
		pass
	else:
		isAttacking = false
		wasAttackButtonPressed = Input.is_action_pressed("ui_accept")  # Actualizar la variable para el siguiente fotograma

		if input_vector != Vector2.ZERO:
			animationPlayer.play("Caminar")
			Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			animationPlayer.play("quieto")
			Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	Velocity = move_and_slide(Velocity)
