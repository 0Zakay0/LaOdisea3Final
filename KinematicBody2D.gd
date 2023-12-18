extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 300
const FRICTION = 500
var Velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
var is_attacking = false
var attack_cooldown = 1.0
var attack_timer = 0.0
var damage_amount = 1

var player_health = 101  # Initial health value

# HUD elements
onready var healthLabel = $HUDCanvasLayer/HealthLabel

func _ready():
	connect("player_hit", self, "_on_player_hit")
	connect("player_hurt", self, "_on_player_hurt")

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
		Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if input_vector != Vector2.ZERO:
			animationPlayer.play("Caminar")
			Velocity = Velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			animationPlayer.play("quieto")
			Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	Velocity = move_and_slide(Velocity)
	
	
func reset_position():
	position = Vector2(40, 250)  # Cambia esto según las coordenadas deseadas
	
func update_hud():
	# Update the player's health
	player_health -= damage_amount
	if player_health <= 0:
		healthLabel.text = "GAME OVER"
		reset_position()
		player_health = 100 
		
		# Ensure health doesn't go below zero
		# Handle player death or other game over logic here

	# Update the health label in the HUD
	healthLabel.text = "Health: " + str(player_health)
	

	# Lógica para manejar el daño infligido por la Hitbox, como restar la salud del enemigo o reproducir una animación de ataque


	# Lógica para manejar el daño recibido por la Hurtbox, como restar la salud del jugador o reproducir una animación de herida
	


func _on_Hurtbox_area_entered(area):
	emit_signal("player_hurt", damage_amount)
	update_hud()
	
