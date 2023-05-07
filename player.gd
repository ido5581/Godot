extends "res://BaseChar.gd"

var max_speed = 250
var acc =0.32
var up = Vector2.UP
var gravity =32
var max_jump_height = -685
var snap_dir = Vector2.DOWN
var snap_length = 32
var snap_threshold = float(deg2rad(45))
var snap_vector = snap_dir*snap_length
var zoomed = false
var motion = Vector2.ZERO
var direction


func _ready():
	add_to_group("player")

func _physics_process(delta): 
	motion = move_and_slide(motion,up , true, 4,snap_threshold)
	motion.y += gravity
	x_movement()
	y_movement(delta)

func x_movement():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
		motion.x = lerp(motion.x , max_speed , acc)
		direction = 1

	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = lerp(motion.x , -max_speed , acc)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
		direction = -1
	else:
		motion.x = lerp(motion.x , 0 ,0.7)
		$AnimatedSprite.play("idle")
		
func y_movement(delta):
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = max_jump_height		
			motion.x = lerp(motion.x , 0 , 0.28)
	else: #NOT ON  FLOOR
		if motion.y < 0: # in the air
			$AnimatedSprite.play("jump")
		else: #falling
			$AnimatedSprite.play("fall")

func _input(event):
	if !zoomed and Input.is_action_just_pressed("zoom in"):
			get_tree().call_group("camera" , "enable_zoom")
			zoomed = true			
	if zoomed and Input.is_action_just_pressed("zoom out"):
		get_tree().call_group("camera" , "disable_zoom")
		zoomed = false
		
func attacked():
	$AnimationPlayer.play("Took_hit")
	



	
