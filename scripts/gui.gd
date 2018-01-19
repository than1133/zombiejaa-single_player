
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var live
var mag
var armor
var live_label
var mag_label
var live_bar
var armor_bar
var armor_value

func _ready():
	live_bar = get_node("livebar")
	live_label = get_node("Live")
	mag_label = get_node("Magazine")
	armor_bar = get_node("armor_bar")
	armor_value = get_node("armor_value")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	live = get_parent().get_parent().live
	mag = get_parent().get_parent().mag
	armor = get_parent().get_parent().armor_value
	live_label.set_text("HP :     "+str(live)+"/100")
	mag_label.set_text("Magezine : "+str(mag)+"/"+str(get_parent().get_parent().mag_max))
	live_bar.set_value(live)
	armor_bar.set_value(armor)
	armor_value.set_text(str(armor))
	if mag <= 0:
		get_node("reload").show()
	else:
		get_node("reload").hide()

func set_player_name(name):
	get_node("Name").set_text(name)