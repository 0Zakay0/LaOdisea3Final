extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 300
const FRICTION = 500
var Velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
var is_attacking = false  # Aquí se declara la variable is_attacking
var attack_cooldown = 1.0
var attack_timer = 0.0


func _ready():
	# Código de inicialización aquí, si es necesario
	pass

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			attack_timer = attack_cooldown

	if Input.is_action_pressed("ui_accept") and not is_attacking:
		is_attacking = true
		attack_timer = attack_cooldown
		animationPlayer.play("Atacar")

	if is_attacking and animationPlayer.is_playing():
		# Aplica aceleración suave durante el ataque
		Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if input_vector != Vector2.ZERO:
			animationPlayer.play("Caminar")
			Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			animationPlayer.play("quieto")
			Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	Velocity = move_and_slide(Velocity)


