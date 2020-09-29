extends KinematicBody2D


const UP = Vector2(0,-1)
const SLOPE_STOP = 64


onready var body = $Body
onready var ground_raycasts = $GroundRaycasts
onready var jet_pack = $JetPack


var move_speed = 5*Globals.tile_size
var velocity = Vector2()
var gravity = 400
var jump_velocity = -200
var is_grounded
var jetpack_power = -500



#func _jet_pack():
#	var fire_force = jet_pack.global_position.direction_to(get_global_mouse_position())
#	var reversed_fire_force= fire_force*jetpack_power
#	return reversed_fire_force

func find_grav():
	var grav
	if Globals.gravity != Globals.normie_grav:
		grav = global_position.direction_to(Globals.gravity)*gravity
	else: 
		grav = Vector2(0,1)*gravity
	return grav


func _physics_process(delta):
	_get_input()
	velocity += find_grav()*delta
	jet_pack.rotation = (get_global_mouse_position()-jet_pack.global_position).angle()
	
#	if Input.is_action_just_pressed("rotate_left"):
#		velocity = _jet_pack()
#	else:
		
	velocity = move_and_slide(velocity,UP,SLOPE_STOP)
	
	
	is_grounded = _check_is_grounded(ground_raycasts)

func jump(jump_power):
	velocity.y=jump_power

func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		jump(jump_velocity)

func _get_input():
	var move_direction = -int(Input.is_action_pressed("move_left")) +int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x,move_speed*move_direction, _get_h_weight())
	if move_direction !=0:
		body.scale.x = move_direction


func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func _check_is_grounded(raycasts):
	if is_on_floor():
		return true
	else:
		return false
	
	
	
	
	
#	for raycast in raycasts.get_children():
#		if raycast.is_colliding():
#			return true
#
#
#	return false


