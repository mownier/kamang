
extends Node

const MOVE_NORTH = "n"
const MOVE_SOUTH = "s"
const MOVE_EAST = "e"
const MOVE_WEST = "w"
const MOVE_NORTHEAST = "ne"
const MOVE_NORTHWEST = "nw"
const MOVE_SOUTHEAST = "se"
const MOVE_SOUTHWEST = "sw"

func _ready():
	pass

func process_archer(event, archer):
	var current_move
	if event.is_action("move_north"):
		current_move = MOVE_NORTH
	elif event.is_action("move_south"):
		current_move = MOVE_SOUTH
	elif event.is_action("move_east"):
		current_move = MOVE_EAST
	elif event.is_action("move_west"):
		current_move = MOVE_WEST
	elif event.is_action("move_northeast"):
		current_move = MOVE_NORTHEAST
	elif event.is_action("move_northwest"):
		current_move = MOVE_NORTHWEST
	elif event.is_action("move_southeast"):
		current_move = MOVE_SOUTHEAST
	elif event.is_action("move_southwest"):
		current_move = MOVE_SOUTHWEST
	
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
		
		if moving:
			archer.run(current_move)
		else:
			archer.idle(current_move)

# @param pos Mouse position
# @param size Viewport's size
func identify_direction(pos, size):
	var dir
	var w = size.width
	var h = size.height
	
	if ((pos.x > w / 3 and pos.x < (w * 2) / 3) and
		(pos.y > 0 and pos.y < h / 2)):
		dir = MOVE_NORTH
		
	elif ((pos.x > w / 3 and pos.x < (w * 2) / 3) and
		(pos.y > h / 2 and pos.y < h)):
		dir = MOVE_SOUTH
		
	elif ((pos.y > h / 3 and pos.y < (h * 2) / 3) and
		(pos.x > 0 and pos.x < w / 2)):
		dir = MOVE_WEST
		
	elif ((pos.y > h / 3 and pos.y < (h * 2) / 3) and
		(pos.x > w / 2 and pos.x < w)):
		dir = MOVE_EAST
		
	elif ((pos.x > (w * 2) / 3 and pos.x < w) and
		(pos.y > 0 and pos.y < h / 3)):
		dir = MOVE_NORTHEAST
		
	elif ((pos.x > 0 and pos.x < w / 3) and
		(pos.y > 0 and pos.y < h / 3)):
		dir = MOVE_NORTHWEST
		
	elif ((pos.x > (w * 2) / 3 and pos.x < w) and
		(pos.y > (h * 2) / 3 and pos.y < h)):
		dir = MOVE_SOUTHEAST
		
	elif ((pos.x > 0 and pos.x < w / 3) and
		(pos.y > (h * 2) / 3 and pos.y < h)):
		dir = MOVE_SOUTHWEST
	
	return dir
