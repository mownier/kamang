
extends Node2D

onready var g = get_node("/root/global")
onready var hero = get_node("elements/hero")
onready var top_left = get_node("helper/top_left")
onready var bottom_right = get_node("helper/bottom_right")
onready var trader = get_node("elements/trader")

func _ready():
	hero.stance(g.MOVE_NORTHEAST)
	var top = top_left.get_pos().y
	var left = top_left.get_pos().x
	var bottom = bottom_right.get_pos().y
	var right = bottom_right.get_pos().x
	hero.set_camera_limit(top, left, bottom, right)
	
	trader.dialogue = "res://source/dialogues/quest_1.json"
