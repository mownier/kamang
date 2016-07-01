
extends KinematicBody2D

onready var g = get_node("/root/global")
onready var anim = get_node("sprite/anim")

func _ready():
	anim.play("run_ne")


