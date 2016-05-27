
extends Node2D

onready var g = get_node("/root/global")
onready var archer = get_node("nav/walls/archer")
onready var tuscan = get_node("nav/walls/tuscan")
onready var nav = get_node("nav")

func _ready():
	archer.idle(g.MOVE_NORTHEAST)
	tuscan.activate_ai()
