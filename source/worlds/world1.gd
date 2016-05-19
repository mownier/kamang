
extends Node2D

onready var g = get_node("/root/global")
onready var archer = get_node("archer")
onready var move

func _ready():
	archer.idle(g.MOVE_NORTHEAST)
	set_process_input(true)

func _input(event):
	var current_move
	if event.is_action("move_north"):
		current_move = g.MOVE_NORTH
	elif event.is_action("move_south"):
		current_move = g.MOVE_SOUTH
	elif event.is_action("move_east"):
		current_move = g.MOVE_EAST
	elif event.is_action("move_west"):
		current_move = g.MOVE_WEST
	elif event.is_action("move_northeast"):
		current_move = g.MOVE_NORTHEAST
	elif event.is_action("move_northwest"):
		current_move = g.MOVE_NORTHWEST
	elif event.is_action("move_southeast"):
		current_move = g.MOVE_SOUTHEAST
	elif event.is_action("move_southwest"):
		current_move = g.MOVE_SOUTHWEST
	
	if current_move != null:
		var moving = true
		if (event.is_action_released("move_north") or
			event.is_action_released("move_south") or
			event.is_action_released("move_east") or
			event.is_action_released("move_west") or
			event.is_action_released("move_northeast") or
			event.is_action_released("move_northwest") or
			event.is_action_released("move_southeast") or
			event.is_action_released("move_southwest")):
			moving = false
		
		move = current_move
		if moving:
			archer.run(move)
		else:
			archer.idle(move)
