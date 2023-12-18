extends Control


func _ready():
	pass # Replace with function body.

func _on_Jugar_pressed():
	var scene_tree = get_tree()
	scene_tree.change_scene("res://Ecena1.tscn")


func _on_salir_pressed():
	get_tree().quit()
