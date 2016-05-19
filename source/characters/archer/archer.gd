
extends KinematicBody2D

const MOTION_SPEED = 250

onready var global = get_node("/root/global")
onready var anim = get_node("sprite/anim")

var action = Action.new()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_north"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_south"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_west"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_east"):
		motion += Vector2(1, 0)
	if Input.is_action_pressed("move_northeast"):
		motion += Vector2(1, -1)
	if Input.is_action_pressed("move_northwest"):
		motion += Vector2(-1, -1)
	if Input.is_action_pressed("move_southeast"):
		motion += Vector2(1, 1)
	if Input.is_action_pressed("move_southwest"):
		motion += Vector2(-1, 1)
	
	
	motion = motion.normalized()* MOTION_SPEED * delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while is_colliding() and slide_attempts > 0:
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1

func set_current_action(name, direction):
	action.set_name(name)
	action.set_direction(direction)

func play_animation(action, direction):
	stop()
	var name = str(action, "_", direction)
	anim.play(name)

func process_action(verb, direction):
	if action.get_name() != verb or action.get_direction() != direction:
		play_animation(verb, direction)
		set_current_action(verb, direction)

func run(direction):
	process_action("run", direction)

func idle(direction):
	process_action("idle", direction)

func stop():
	if anim.is_playing():
		anim.stop(false)


class Action extends Reference:
	
	var name
	var direction
	
	func set_name(what):
		name = what
	
	func get_name():
		return name
	
	func set_direction(what):
		direction = what
	
	func get_direction():
		return direction