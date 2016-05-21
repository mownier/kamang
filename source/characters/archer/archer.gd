
extends KinematicBody2D

const MOTION_SPEED = 250

onready var g = get_node("/root/global")
onready var anim = get_node("sprite/anim")

var action = Action.new()
var destination

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	
	if destination != null:
		if action.get_direction() == g.MOVE_NORTH:
			motion += Vector2(0, -1)
		elif action.get_direction() == g.MOVE_SOUTH:
			motion += Vector2(0, 1)
		elif action.get_direction() == g.MOVE_WEST:
			motion += Vector2(-2, 0)
		elif action.get_direction() == g.MOVE_EAST:
			motion += Vector2(2, 0)
		elif action.get_direction() == g.MOVE_NORTHEAST:
			motion += Vector2(2, -1)
		elif action.get_direction() == g.MOVE_NORTHWEST:
			motion += Vector2(-2, -1)
		elif action.get_direction() == g.MOVE_SOUTHEAST:
			motion += Vector2(2, 1)
		elif action.get_direction() == g.MOVE_SOUTHWEST:
			motion += Vector2(-2, 1)
	
	if Input.is_action_pressed("move_north"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_south"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_west"):
		motion += Vector2(-2, 0)
	if Input.is_action_pressed("move_east"):
		motion += Vector2(2, 0)
	if Input.is_action_pressed("move_northeast"):
		motion += Vector2(2, -1)
	if Input.is_action_pressed("move_northwest"):
		motion += Vector2(-2, -1)
	if Input.is_action_pressed("move_southeast"):
		motion += Vector2(2, 1)
	if Input.is_action_pressed("move_southwest"):
		motion += Vector2(-2, 1)
	
	motion = motion.normalized() * MOTION_SPEED * delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while is_colliding() and slide_attempts > 0:
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1
	
	print(get_pos())

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

func move_to(dest, direction):
	print(dest)
	run(direction)
	destination = Vector2(dest.x, dest.y)


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