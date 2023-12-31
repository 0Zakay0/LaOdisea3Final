extends KinematicBody2D

export var speed = 100
var player_position
var target_position
var original_position
var player_detected = false
onready var player = get_parent().get_node("Player")

func _ready():
	
	original_position = position

func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()

	if position.distance_to(player_position) < 115:
		
		move_and_slide(target_position * speed)
		player_detected = true
	else:
		player_detected = false
	if not player_detected:
		var direction_to_original = (original_position - position).normalized()
		move_and_slide(direction_to_original * speed)


func _on_Hurtbox_area_entered(area):
	# Verificar si el área entrante pertenece al jugador antes de eliminar
	if area.get_parent().get_parent() == player:
		queue_free()
