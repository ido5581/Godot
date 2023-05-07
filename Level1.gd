extends Node2D

var HP = 3

func _ready():
	add_to_group("GameState")

func hurt():
	HP -= 1
	$player.attacked()
	print("HP: ",HP)
	get_tree().call_group("GUI" , "update_lives", HP)
	if HP == 0:
		end_game()

func end_game():
	get_tree().quit()
