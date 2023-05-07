
extends Camera2D


func _ready():
	add_to_group("camera")                              
	zoom.x = 1
	zoom.y = 1



func enable_zoom():
	
	$AnimationPlayer.play("zoom")
	yield(get_tree().create_timer(1), "timeout")

	
func disable_zoom():
	$AnimationPlayer.play_backwards("zoom")
	yield(get_tree().create_timer(1), "timeout")

	 
