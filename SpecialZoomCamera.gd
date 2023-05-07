extends Camera2D


var make_current = false

func _on_Area2D_body_entered(body):
	if body == KinematicBody2D:
		make_current = true
	if make_current:
		make_current()


func _on_Area2D_body_exited(body):
	make_current = false
