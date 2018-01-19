
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var id
var timing
var gun_sound
onready var live = 100
var mag = 15
var mag_max = 15
var fire_rate = 1
var reload_time = 1
var reloading = false
var player
var kill_by
var score
var score_int = 0 
var move_speed = 5
var point_upgrade = 0
var armor_value = 0
var god_mode = false
var ok_show_score = false

func _ready():
	player = get_node("Sprite")
	get_node("bgm").play(0)
	gun_sound = get_node("gun")
	timing = get_node("Timer")
	score = get_node("cl/Score")
	update_gun_state()
	get_node("cl/GodMode").hide()
	get_node("reload_bar").hide()
	set_fixed_process(true)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("god_mode"):
		if live > 0:
			get_node("cl/GodMode").show()
			get_node("cl/t_god_mode").start()
			if god_mode:
				get_node("cl/GodMode").set_text("God Mode = OFF")
				god_mode = false
			else:
				get_node("cl/GodMode").set_text("God Mode = ON")
				god_mode = true
		

func _fixed_process(delta):
	#if get_parent().get_parent().player_count==1 :
	#	live = 100
	get_node("reload_bar").set_value((timing.get_time_left()*100)/1)
	set_zombie_count()
	if live > 0:
		get_node("cl/GUI").show()
		blood_timer()
		get_node("Camera2D").make_current()
		if god_mode:
			if Input.is_action_pressed("w"):
				move(Vector2(0, -15))
			if Input.is_action_pressed("a"):
				move(Vector2(-15, 0))
			if Input.is_action_pressed("s"):
				move(Vector2(0, 15))
			if Input.is_action_pressed("d"):
				move(Vector2(15, 0))
		else:
			if Input.is_action_pressed("w"):
				move(Vector2(0, -move_speed))
			if Input.is_action_pressed("a"):
				move(Vector2(-move_speed, 0))
			if Input.is_action_pressed("s"):
				move(Vector2(0, move_speed))
			if Input.is_action_pressed("d"):
				move(Vector2(move_speed, 0))
		player.look_at(get_global_mouse_pos())
		
		if mag > 0 and !get_parent().in_wait:
			if Input.is_action_pressed("shoot"):
				if god_mode:
					timing.set_wait_time(0.01)
					if timing.get_time_left() <= 0:
						get_node("Camera2D/AnimationPlayer").play("shoot")
						timing.start()
						bullet()
				else:
					timing.set_wait_time(fire_rate)
					if timing.get_time_left() <= 0:
						get_node("Camera2D/AnimationPlayer").play("shoot")
						mag-=1
						timing.start()
						bullet()
					
		if Input.is_action_pressed("r"):
			get_node("reload_bar").show()
			timing.set_wait_time(reload_time)
			timing.start()
			get_node("reload").play(0)
			reloading = true
		if reloading == true and timing.get_time_left() <= 0:
			mag=mag_max
			get_node("reload_bar").hide()
			reloading = false
		if mag <=0:
			if Input.is_action_pressed("shoot"):
				if timing.get_time_left() <= 0:
					timing.set_wait_time(fire_rate)
					get_node("gun_empty").play(0)
					timing.start()
		
	else:
		if is_in_group("player"):
			remove_from_group("player")
			live=0
			change_pic_when_dead()
			get_node("cl/game_over").show()
				
func blood_timer():
	var blood_time = get_node("cl/blood_time")
	var blood = get_node("cl/blood").set_opacity(blood_time.get_time_left())
	
func damage(damage):
	if !god_mode:
		if armor_value > 0 :
			armor_value-=damage
			if armor_value < 0:
				live+=armor_value
				armor_value = 0
				
		else:
			get_node("cl/blood_time").start()
			live-=damage
	
func get_armor():
	armor_value = 50

func bullet():
	var bullet_ins = load("res://instance/bullet.tscn").instance()
	var fire_ins = load("res://instance/gun_fire.tscn").instance()
	bullet_ins.set_pos(get_node("Sprite/Position2D").get_global_pos()-get_global_pos())
	bullet_ins.set_rot(player.get_rot())
	
	fire_ins.set_pos(get_node("Sprite/Position2D").get_global_pos()-get_global_pos())
	fire_ins.set_rot(player.get_rot())
	
	gun_sound.play(0)
	add_child(bullet_ins)
	add_child(fire_ins)

func change_pic_when_dead():
	player.set_rot(0)
	get_node("Sprite").set_texture(load("res://picture/die.tex"))

func _on_TryAgain_pressed():
	get_tree().change_scene("res://instance/map01.tscn")
	pass # replace with function body

func increase_score(scorer):
	score_int+=scorer
	score.set_text("Score : "+str(score_int))
	pass

func increase_point(p):
	point_upgrade+=p
	
func set_wave_text(w):
	get_node("cl/Wave").set_text(str(w))

func _on_p_heal_pressed():
	if point_upgrade >= 1:
		if live < 100:
			point_upgrade-=1
			live+=30
			if live >= 100:
				live = 100
			update_gun_state()
	pass # replace with function body


func _on_p_move_speed_pressed():
	if point_upgrade >= 1:
		if move_speed < 15:
			point_upgrade-=1
			move_speed+=0.15
			if move_speed >= 15:
				move_speed = 15
			update_gun_state()
	pass # replace with function body


func _on_p_fire_rate_pressed():
	if point_upgrade >= 1:
		if fire_rate > 0.01:
			point_upgrade-=1
			fire_rate-=0.02
			if fire_rate <= 0:
				fire_rate = 0.01
			update_gun_state()
	pass # replace with function body


func _on_p_magazine_max_pressed():
	if point_upgrade >= 1:
		point_upgrade-=1
		mag_max+=2
		update_gun_state()
	pass # replace with function body

func show_gun_state():
	get_node("cl/gun_stat").show()
	
func hide_gun_state():
	get_node("cl/gun_stat").hide()
	
func update_gun_state():
	get_node("cl/gun_stat/Upgrade").set_text("Upgrade Point: "+str(point_upgrade))
	get_node("cl/gun_stat/Heal").set_text("Heal")
	get_node("cl/gun_stat/MoveSpeed").set_text("MoveSpeed: "+ str(move_speed))
	get_node("cl/gun_stat/FireRate").set_text("FireRate: "+ str(fire_rate))
	get_node("cl/gun_stat/ReloadSpeed").set_text("ReloadSpeed: "+ str(reload_time))
	get_node("cl/gun_stat/MagazineMax").set_text("MagazineMax: "+str(mag_max)) 

func _on_GoTitle_pressed():
	Input.set_mouse_mode(0)
	get_tree().change_scene("res://instance/title.tscn")
	pass # replace with function body

func set_zombie_count():
	var z = get_parent().get_node("zom_spawn").zombie_spawned
	var zd = get_parent().get_node("zom_spawn").zombie_dead
	var zw = get_parent().get_node("zom_spawn").zombie_wave
	get_node("cl/Zombie").set_text("Zombies: "+str(z-zd)+"/"+str(zw))
	

func _on_p_reload_speed_pressed():
	if point_upgrade >= 1:
		if reload_time > 0.01:
			point_upgrade-=1
			reload_time-=0.02
			if reload_time <= 0:
				reload_time = 0.01
			update_gun_state()
	pass # replace with function body


func _on_t_god_mode_timeout():
	get_node("cl/GodMode").hide()
	pass # replace with function body
