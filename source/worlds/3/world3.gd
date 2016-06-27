
extends Node2D

onready var g = get_node("/root/global")
onready var minotaur = get_node("elements/minotaur")
onready var top_left = get_node("helper/top_left")
onready var bottom_right = get_node("helper/bottom_right")

func _ready():
	minotaur.stance(g.MOVE_NORTHEAST)
	var top = top_left.get_pos().y
	var left = top_left.get_pos().x
	var bottom = bottom_right.get_pos().y
	var right = bottom_right.get_pos().x
	minotaur.set_camera_limit(top, left, bottom, right)
