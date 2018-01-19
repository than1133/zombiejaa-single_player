extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var save_file = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var save = File.new()
	if save.file_exists("./save.sv"):
		print("Have save file")
		save.open("./save.sv", save.READ)
		save_file = save.get_var()
		print(save_file)
	else:
		print("No save file")
		save.open("./save.sv", save.WRITE)
		save.store_var(save_file)
		if save.file_exists("./save.sv"):
			print("Create save file successed")
		else:
			print("Failed to create save file")
		save.close()
	pass
	
func save_game(saving):
	save_file.append(saving)
	var tmp
	for i in range(0, save_file.size()-1):
		for j in range(0, save_file.size()-1):
			if save_file[j][2] < save_file[j+1][2]:
				tmp = save_file[j]
				save_file[j] = save_file[j+1]
				save_file[j+1] = tmp
	
	while(save_file.size() > 10):
			save_file.remove(10)
	
	var save = File.new()
	save.open("./save.sv", save.WRITE)
	save.store_var(save_file)
	save.close()