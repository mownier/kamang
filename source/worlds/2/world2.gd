
extends Node2D

onready var g = get_node("/root/global")
onready var archer = get_node("nav/walls/archer")
onready var tuscan = get_node("nav/walls/tuscan")
onready var nav = get_node("nav")
onready var hunt_trigger = get_node("hunt_trigger")

func _ready():
	hunt_trigger.set_prey(archer)
	hunt_trigger.connect("on_hunt_activated", self, "on_hunt_activated")
	hunt_trigger.connect("on_hunt_deactivated", self, "on_hunt_deactivated")
	archer.idle(g.MOVE_NORTHEAST)
	tuscan.hunt(archer)
	tuscan.activate_ai()

func on_hunt_activated(prey):
#	tuscan.hunt(prey)
	pass

func on_hunt_deactivated(prey):
#	tuscan.stop_hunt(prey)
	pass
