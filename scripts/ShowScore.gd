extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var score
var scroll_Con

func _ready():
	var l = ["No.","Name","Wave","Score"]
	var n = ["asdfasdfasdf",".,m/.m", "asdfasdfad14", "1241234", "lkjlkl;kjl"]
	for i in range(0, 4):
		score = load("res://instance/ShowScore_Score.tscn").instance()
		score.set_text(l[i])
		get_node("ScrollContainer/GridContainer").add_child(score)

#f7dc00

func apearing(name=null):
	for i in range(0, save.save_file.size()):
		if name != null:
			if save.save_file[i][0] == name:
				score = load("res://instance/ShowScore_Score.tscn").instance()
				score.set_text(str(i+1)+". ")
				score.set("custom_colors/font_color", Color(0,1,0,1))
				get_node("ScrollContainer/GridContainer").add_child(score)
				for j in range(0, 3):
					score = load("res://instance/ShowScore_Score.tscn").instance()
					score.set_text(str(save.save_file[i][j]))
					score.set("custom_colors/font_color", Color(0,1,0,1))
					get_node("ScrollContainer/GridContainer").add_child(score)
			else:
				score = load("res://instance/ShowScore_Score.tscn").instance()
				score.set_text(str(i+1)+". ")
				get_node("ScrollContainer/GridContainer").add_child(score)
				for j in range(0, 3):
					score = load("res://instance/ShowScore_Score.tscn").instance()
					score.set_text(str(save.save_file[i][j]))
					get_node("ScrollContainer/GridContainer").add_child(score)
		else:
			score = load("res://instance/ShowScore_Score.tscn").instance()
			score.set_text(str(i+1)+". ")
			get_node("ScrollContainer/GridContainer").add_child(score)
			for j in range(0, 3):
				score = load("res://instance/ShowScore_Score.tscn").instance()
				score.set_text(str(save.save_file[i][j]))
				get_node("ScrollContainer/GridContainer").add_child(score)