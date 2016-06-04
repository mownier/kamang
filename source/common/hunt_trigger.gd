
extends Area2D

signal on_hunt_activated(prey)
signal on_hunt_deactivated(prey)

var prey
var enters = 0
var exits = 0

func _ready():
	connect("body_enter", self, "on_body_enter")
	connect("body_exit", self, "on_body_exit")

func set_prey(what):
	prey = what

func get_prey():
	return prey

func on_body_enter(body):
	emit_signal("on_hunt_activated", prey)

func on_body_exit(body):
	emit_signal("on_hunt_deactivated", prey)


