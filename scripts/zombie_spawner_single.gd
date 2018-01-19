extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var zombies = {}
var zombie_wave = 0
var zombie_spawned = 0
var zombie_dead = 0
var t
var armor
var armor_spawned = false
var player_armor
var has_armor_in_map = false

func _ready():
	zombies[0] = "res://instance/Enemy.tscn"
	zombies[1] = "res://instance/Enemy2.tscn"
	zombies[2] = "res://instance/Enemy3.tscn"
	t = get_parent().get_node("wait_zom_spawn")
	player_armor = get_parent().get_node("player").armor_value
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	zombie_wave = 10+(abs(get_parent().wave-1)*10)
	if !get_parent().in_wait:
		if armor_spawned == false and player_armor <= 0 and has_armor_in_map == false:
			randomize()
			armor = load("res://instance/Armor.tscn").instance()
			armor.set_pos(get_child(int(rand_range(0, 16))).get_pos())
			add_child(armor)
			armor_spawned = true
			has_armor_in_map = true
		if zombie_spawned < zombie_wave and t.get_time_left() <= 0:
			randomize()
			var zom 
			if get_parent().wave <= 1:
				zom = load(zombies[0]).instance()
			elif get_parent().wave > 1 and get_parent().wave <= 2:
				zom = load(zombies[int(rand_range(0,2))]).instance()
			elif get_parent().wave >2:
				zom = load(zombies[int(rand_range(0,3))]).instance()
			zom.set_pos(get_child(int(rand_range(0, 16))).get_pos())
			add_child(zom)
			zombie_spawned+=1
		if zombie_dead == zombie_wave:
			zombie_spawned = 0
			zombie_dead = 0
			armor_spawned = false
			get_parent().begin_wait_wave()
		
func increase_zom_dead():
	zombie_dead+=1