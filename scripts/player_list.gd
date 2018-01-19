extends Node2D

var wave = 0
var player
var t_waiting_wave
var in_wait = false
var p_dead = true

func _ready():
	player = get_node("player")
	var player_spawner = get_node("player_spawner")
	randomize()
	player.set_pos(player_spawner.get_child(int(rand_range(0, 5))).get_pos())
	# Called every time the node is added to the scene.
	# Initialization here
	t_waiting_wave = get_node("waiting_wave")
	t_waiting_wave.start()
	in_wait = true
	get_node("bgm_in_game").play()
	set_fixed_process(true)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("esc"):
		if player.live > 0:
			get_node("CanvasLayer/gui_all/pause").show()
			get_tree().set_pause(true)

func _fixed_process(delta):
	if player.live <= 0:
		if p_dead == true:
			get_node("CanvasLayer/gui_all/Name").show()
			get_node("CanvasLayer/gui_all/Name_OK").show()
			p_dead = false
			
	if in_wait == true:
		if int(t_waiting_wave.get_time_left()) == 3:
			get_node("ready").play()
		player.show_gun_state()
		get_node("CanvasLayer/Wait_time").show()
		get_node("CanvasLayer/Wait_time").set_text("Waiting For Next Wave. Time Left: "+str(int(t_waiting_wave.get_time_left()))+" Seccond")
	else:
		get_node("CanvasLayer/Wait_time").hide()
		player.hide_gun_state()
		
	player.set_wave_text("Wave : "+str(wave))
	get_node("CanvasLayer/gui_all/fps").set_text("FPS : " + str(OS.get_frames_per_second()))
	
func _on_Resume_pressed():
	get_node("CanvasLayer/gui_all/pause").hide()
	get_tree().set_pause(false)
	pass # replace with function body

func begin_wait_wave():
	in_wait = true
	t_waiting_wave.start()
	player.point_upgrade+=10.50+(wave*2)
	player.update_gun_state()
	get_node("combat").stop()
	get_node("bgm_in_game").play()

func _on_waiting_wave_timeout():
	in_wait = false
	wave+=1
	get_node("combat").play()
	get_node("bgm_in_game").stop()
	pass # replace with function body

func _on_ToMain_pressed():
	Input.set_mouse_mode(0)
	get_tree().set_pause(false)
	get_tree().change_scene("res://instance/title.tscn")
	pass # replace with function body

func _on_Name_OK_pressed():
	if get_node("CanvasLayer/gui_all/Name").get_text() != "":
		get_node("CanvasLayer/gui_all/Name").hide()
		get_node("CanvasLayer/gui_all/Name_OK").hide()
		var saving = []
		saving.append(get_node("CanvasLayer/gui_all/Name").get_text())
		saving.append(wave)
		saving.append(player.score_int)
		save.save_game(saving)
		player.get_node("cl/ShowScore").show()
		player.get_node("cl/ShowScore").apearing(get_node("CanvasLayer/gui_all/Name").get_text())
		player.get_node("cl/TryAgain").show()
		player.get_node("cl/GoTitle").show()
	else:
		print("Name Input is Null")
	pass # replace with function body
