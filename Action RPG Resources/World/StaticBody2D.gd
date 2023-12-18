extends StaticBody2D

onready var player = get_parent().get_node("Player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	if area.get_parent().get_parent() == player:
		player.emit_signal("player_hit")
		emit_signal("player_hit")  # Emitir señal para consistencia en manejo de eventos
		queue_free()
