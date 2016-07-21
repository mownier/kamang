tool

extends KinematicBody2D

var do_stance = true
var do_rush = false
var do_attack = false

onready var anim = get_node("sprite/anim")
onready var g = get_node("/root/global")
onready var action = g.Action.new()

func _ready():
	var pos = Vector2(568/2, 320/2) 
	set_pos(pos)
	set_fixed_process(true)

func _fixed_process(delta):
	if do_stance:
		stance(g.MOVE_EAST)
	elif do_rush:
		rush(g.MOVE_EAST)
	elif do_attack:
		if not anim.is_playing():
			print("playing")
			attack(g.MOVE_EAST)

func stance(direction):
	anim.set_speed(1/0.9)
	process_action("stance", direction)

func rush(direction):
	anim.set_speed(1/0.8)
	process_action("rush", direction)

func attack(direction):
	anim.set_speed(1/0.4)
	process_action("attack", direction)

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
