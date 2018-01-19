extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_parent().increase_zom_dead()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if get_parent().zombie_dead == get_parent().zombie_wave:
		queue_free()
	