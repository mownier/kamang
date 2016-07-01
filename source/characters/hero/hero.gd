# Stance (4 frames)
# Running (8 frames)
# Melee Swing (4 frames)
# Block (2 frames)
# Hit and Die (6 frames)
# Cast Spell (4 frames)
# Shoot Bow (4 frames)
# 32 x 8
extends KinematicBody2D

onready var anim = get_node("anim")
onready var g = get_node("/root/global")
onready var action = g.Action.new()
onready var camera = get_node("camera")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var direction = g.current_direction
	var motion = g.get_motion(direction)
	
	if motion.x == 0 and motion.y == 0:
		direction = action.get_direction()
		var triggered = g.triggered_action
		if triggered != null and triggered == "swing":
			process_action(triggered, direction)
			g.triggered_action = null
		else:
			if action.get_name() == "run" or not anim.is_playing():
				stance(direction)
	else:
		run(direction)
	
	motion = motion.normalized() * g.HERO_SPEED * delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while is_colliding() and slide_attempts > 0:
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1

func stance(direction):
	process_action("stance", direction)

func run(direction):
	process_action("run", direction)

func swing(direction):
	process_action("swing", direction)

func process_action(name, direction):
	if action.get_name() != name or action.get_direction() != direction:
		play_animation(name, direction)
		set_current_action(name, direction)

func set_current_action(name, direction):
	action.set_name(name)
	action.set_direction(direction)

func play_animation(name, direction):
	stop_animation()
	var anim_name = str(name, "_", direction)
	anim.play(anim_name)

func stop_animation():
	if anim.is_playing():
		anim.stop(false)

func set_camera_limit(top, left, bottom, right):
	camera.set_limit(MARGIN_TOP, top)
	camera.set_limit(MARGIN_LEFT, left)
	camera.set_limit(MARGIN_BOTTOM, bottom)
	camera.set_limit(MARGIN_RIGHT, right)


