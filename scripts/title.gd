extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var t
var t_state = 0
#t_state: 0 = time to exit, 1 = time to start

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("StreamPlayer").play()
	get_node("Title").show()
	get_node("Creadit").hide()
	get_node("HighScore").hide()
	t = get_node("Timer")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	flickering_light()
	pass

func flickering_light():
	randomize()
	var r = int(rand_range(0, 4))
	if r == 1:
		get_node("LightShaft").show()
	else:
		get_node("LightShaft").hide()
	pass

func _on_Exit_pressed():
	get_node("StreamPlayer4").play()
	t_state = 0
	t.start()
	pass # replace with function body


func _on_Credit_pressed():
	get_node("Title").hide()
	get_node("Creadit").show()
	get_node("AnimationPlayer").play("go_cretdit")
	get_node("StreamPlayer4").play()
	pass # replace with function body


func _on_Start_pressed():
	get_node("StreamPlayer4").play()
	t_state = 1
	t.start()
	pass # replace with function body


func _on_Back_pressed():
	get_node("Creadit").hide()
	get_node("Title").show()
	get_node("AnimationPlayer").play("go_title")
	get_node("StreamPlayer4").play()
	pass # replace with function body


func _on_Back_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_Start_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_Credit_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_Exit_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_Timer_timeout():
	if t_state == 0:
		get_tree().quit()
	elif t_state == 1:
		get_tree().change_scene("res://instance/map01.tscn")
	pass # replace with function body


func _on_HighScore_pressed():
	get_node("Title").hide()
	get_node("HighScore").show()
	get_node("HighScore/ShowScore").apearing()
	get_node("AnimationPlayer").play("title_to_high")
	get_node("StreamPlayer4").play()
	pass # replace with function body


func _on_HighScore_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_BackFormHighScore_mouse_enter():
	get_node("StreamPlayer 2").play()
	pass # replace with function body


func _on_BackFormHighScore_pressed():
	get_node("HighScore").hide()
	get_node("Title").show()
	get_node("AnimationPlayer").play("high_to_title")
	get_node("StreamPlayer4").play()
	pass # replace with function body
