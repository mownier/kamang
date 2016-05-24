
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
