
extends KinematicBody2D

onready var anim = get_node("sprite/anim")
onready var g = get_node("/root/global")
onready var action = g.Action.new()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	pass

func stance(direction):
	process_action("stance", direction)

func rush(direction):
	process_action("rush", direction)

func attack(direction):
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
