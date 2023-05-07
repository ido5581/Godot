extends CanvasLayer

func _ready():
	
	add_to_group("GUI")
	$Control/HBoxContainer/Label.text = "HP: 3"
	
	
func update_lives(lives_left):
	var HP = lives_left
	$Control/HBoxContainer/Label.text ="HP: "+ str(HP)
