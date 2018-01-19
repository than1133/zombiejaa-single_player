extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.is_in_group("player"):
		get_parent().has_armor_in_map == false
		body.get_armor()
		queue_free()
		print("Player get armor")
	pass # replace with function body
