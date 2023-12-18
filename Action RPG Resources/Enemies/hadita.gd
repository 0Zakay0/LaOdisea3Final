extends KinematicBody2D

export var speed = 100
var player_position
var target_position
var original_position
onready var player = get_parent().get_node("Player")
var damage_amount = 10

func _ready():
	original_position = position

func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()

	if position.distance_to(player_position) < 115:
		move_and_slide(target_position * speed)
	else:
		var direction_to_original = (original_position - position).normalized()
		move_and_slide(direction_to_original * speed)

func _on_Hurtbox_area_entered(area):
	if area.get_parent().get_parent() == player:
		queue_free()



