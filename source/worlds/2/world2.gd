
extends Node2D

onready var g = get_node("/root/global")
onready var archer = get_node("walls/archer")

func _ready():
	archer.idle(g.MOVE_NORTHEAST)
