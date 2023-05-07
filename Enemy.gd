extends "res://BaseChar.gd"

var motion = Vector2.ZERO
var speed = 100
var gravity = 100
var up = Vector2.UP
var direction = 1
var walking = true
var player
var is_dead = false
var HP = 3

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	if walking:	
		motion.x = speed * direction
		move_and_slide(motion,up)
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.speed_scale = 1.2
		$AnimatedSprite.play("hit")
		$AnimationPlayer.play("Hit")
		
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	if is_on_wall():
		change_face_direction()
		
	if $RayCast2D.is_colliding() == false:
		change_face_direction()
		
func change_face_direction():
	direction *=-1
	$RayCast2D.position.x *=-1
	$HitDetection/CollisionShape2D.position.x*= -1
	$HitArea.position.x *=-1
	$WeakSpot.position.x *=-1
	
func _on_HitDetection_body_entered(body):
	if body.is_in_group("player"):
		walking = false
	
func _on_HitDetection_body_exited(body):
	walking = true
	
func _on_HitArea_body_entered(body):
	if body.is_in_group("player"):
		if $HitArea/CollisionShape2D.disabled == false:
			get_tree().call_group("GameState" , "hurt")
	
func _on_WeakSpot_body_entered(body):
	HP -= 1
	if HP == 0:
		$AnimatedSprite.play("dying")
		

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		change_face_direction()
