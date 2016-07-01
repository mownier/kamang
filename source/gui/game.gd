
extends Node2D

onready var g = get_node("/root/global")
onready var world = g.get_current_world()

func _ready():
	var w = load(world).instance()
	add_child(w)

