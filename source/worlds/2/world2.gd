
extends Node2D

onready var g = get_node("/root/global")
onready var archer = get_node("archer")

func _ready():
	archer.idle(g.MOVE_NORTHEAST)
	set_process_input(true)

func _input(event):
	g.process_archer(event, archer)
	if event.is_action_released("mouse_move"):
		var pos = event.pos
		var size = get_viewport_rect().size
		var dir = g.identify_direction(pos, size)
		if dir != null:
			archer.run(dir)