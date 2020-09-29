extends KinematicBody2D

export (int,0,200) var push = 50


var respawn = Vector2.ZERO
var normal_speed = 200
var fast_speed = 300
var speed = normal_speed
var rotate_speed = 25
var hum_weight = 0.06

var velocity = Vector2()
var input_vec = Vector2()
var friction = 0.05
var acceleration = 0.07

func _ready():
	$MoveHum.play()
	$MoveHum.volume_db = -80

func die():
	global_position = respawn


func get_input():
	input_vec = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		input_vec.x +=1
	if Input.is_action_pressed("move_left"):
		input_vec.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vec.y += 1
	if Input.is_action_pressed("move_up"):
		input_vec.y -= 1
	
	
	input_vec = input_vec.normalized()*speed



func _rotate(delta):
	var rotation_direction = -int(Input.is_action_pressed("rotate_left"))+int(Input.is_action_pressed("rotate_right"))
	rotation_degrees = rotation_direction*rotate_speed


func boost():
	if Input.is_action_pressed("boost"):
		speed = fast_speed
	else:
		speed = normal_speed

func _physics_process(delta):
	get_input()
	_rotate(delta)
	boost()
	if input_vec.length() > 0:
		velocity = velocity.linear_interpolate(input_vec, acceleration)
		$MoveHum.pitch_scale = lerp($MoveHum.pitch_scale,1.3,hum_weight)
	else:
		if velocity.length() <0.2:
			velocity = Vector2.ZERO
		else: 
			velocity=velocity.linear_interpolate(Vector2.ZERO,friction)
			$MoveHum.pitch_scale = lerp($MoveHum.pitch_scale,0.5,hum_weight)
	velocity = move_and_slide(velocity,Vector2.ZERO,false,4,PI/4,false)
	
	if velocity.length() == 0:
		$MoveHum.volume_db = -80
	else:
		$MoveHum.volume_db = 2
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal*push)







func _on_CheckPoint_respawn_pos_updated(player, ball):
	respawn = player


func _on_Start_respawn_pos_updated(player, ball):
	respawn = player


func _on_Ball_died():
	die()


func _on_MoveHum_finished():
	$MoveHum.play()
