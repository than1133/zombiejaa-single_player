extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_parent().increase_zom_dead()
	get_node("Particles2D").set_emitting(true)
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	if get_parent().zombie_dead == get_parent().zombie_wave:
		queue_free()
	pass
