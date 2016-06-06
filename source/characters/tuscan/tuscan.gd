
extends KinematicBody2D

const MOTION_SPEED = 150

onready var anim = get_node("sprite/anim")
onready var g = get_node("/root/global")
onready var damage_area = get_node("damage_area")
onready var sword_area = get_node("sword_area")

var Action = preload("res://source/common/action.gd")

var action = Action.new()
var ai = AI.new()
var prey

func _ready():
	add_collision_exception_with(self)
	sword_area.connect("area_enter", self, "on_sword_inflict")
	set_fixed_process(true)

func _fixed_process(delta):
	if action.get_name() != null:
		if action.get_name() == "walk":
			if prey != null:
				ai.on_hunt(delta, self)
			else:
				ai.on_walk(delta, self)
		elif action.get_name().begins_with("attack"):
			ai.on_attack(delta, self)

func on_sword_inflict(object):
	if object.get_parent().get_name().to_lower() == "archer":
		var archer = object.get_parent()
		archer.take_damage()

func hunt(what):
	prey = what

func stop_hunt(what):
	if what == prey:
		prey = null

func play_animation(action, direction):
	stop()
	var name = str(action, "_", direction)
	anim.play(name)

func stop():
	if anim.is_playing():
		anim.stop(false)

func set_current_action(name, direction):
	action.set_name(name)
	action.set_direction(direction)

func process_action(verb, direction):
	if action.get_name() != verb or action.get_direction() != direction:
		play_animation(verb, direction)
		set_current_action(verb, direction)

func walk(direction):
	process_action("walk", direction)

func attack(type, direction):
	process_action(str("attack", type), direction)

func activate_ai():
	var direction = g.get_random_direction()
	walk(direction)


class AI extends Reference:
	
	func on_hunt(delta, tuscan):
		var nav = tuscan.get_parent().get_parent()
		var begin = tuscan.get_global_pos()
		var end = tuscan.prey.get_global_pos()
		var points = nav.get_simple_path(begin, end, true)
		points = Array(points)
		points.invert()
		if points.size() > 1:
			var to_walk = delta * tuscan.MOTION_SPEED
			while to_walk > 0 and points.size() >= 2:
				var from = points[points.size() - 1]
				var to = points[points.size() - 2]
				var d = from.distance_to(to)
				if d <= to_walk:
					points.remove(points.size() - 1)
					to_walk -= d
				else:
					points[points.size() - 1] = from.linear_interpolate(to, to_walk/d)
					to_walk = 0
			
			var at = points[points.size() - 1]
			var rad = at.angle_to_point(begin)
			var degree = rad2deg(rad)
			var direction = tuscan.g.degree2direction(degree)
			tuscan.set_pos(at)
			if direction != null:
				tuscan.walk(direction)
	
	func on_attack(delta, tuscan):
		pass
	
	func on_walk(delta, tuscan):
		var direction = tuscan.action.get_direction()
		var motion = tuscan.g.get_motion(direction)
		
		motion = motion.normalized() * MOTION_SPEED * delta
		motion = tuscan.move(motion)
		
		if tuscan.is_colliding():
			direction = tuscan.g.get_opposite_direction(direction)
			tuscan.walk(direction)
