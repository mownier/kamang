
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

func get_direction():
	var direction
	if Input.is_action_pressed("move_north"):
		direction = MOVE_NORTH
	elif Input.is_action_pressed("move_south"):
		direction = MOVE_SOUTH
	elif Input.is_action_pressed("move_west"):
		direction = MOVE_WEST
	elif Input.is_action_pressed("move_east"):
		direction = MOVE_EAST
	elif Input.is_action_pressed("move_northeast"):
		direction = MOVE_NORTHEAST
	elif Input.is_action_pressed("move_northwest"):
		direction = MOVE_NORTHWEST
	elif Input.is_action_pressed("move_southeast"):
		direction = MOVE_SOUTHEAST
	elif Input.is_action_pressed("move_southwest"):
		direction = MOVE_SOUTHWEST
	return direction

func get_opposite_direction(dir):
	var direction
	if dir == MOVE_NORTH:
		direction = MOVE_SOUTH
	elif dir == MOVE_SOUTH:
		direction = MOVE_NORTH
	elif dir == MOVE_EAST:
		direction = MOVE_WEST
	elif dir == MOVE_WEST:
		direction = MOVE_EAST
	elif dir == MOVE_NORTHEAST:
		direction = MOVE_SOUTHWEST
	elif dir == MOVE_NORTHWEST:
		direction = MOVE_SOUTHEAST
	elif dir == MOVE_SOUTHEAST:
		direction = MOVE_NORTHWEST
	elif dir == MOVE_SOUTHWEST:
		direction = MOVE_NORTHEAST
	
	return direction

func get_random_direction():
	var i = randi() % 8
	var direction
	if i == 0:
		direction = MOVE_NORTH
	elif i == 1:
		direction = MOVE_SOUTH
	elif i == 2:
		direction = MOVE_EAST
	elif i == 3:
		direction = MOVE_WEST
	elif i == 4:
		direction = MOVE_NORTHEAST
	elif i == 5:
		direction = MOVE_NORTHWEST
	elif i == 6:
		direction = MOVE_SOUTHEAST
	elif i == 7:
		direction = MOVE_SOUTHWEST
	
	return direction

func get_motion(direction):
	if direction == MOVE_NORTH:
		return Vector2(0, -1)
	elif direction == MOVE_SOUTH:
		return Vector2(0, 1)
	elif direction == MOVE_WEST:
		return Vector2(-2, 0)
	elif direction == MOVE_EAST:
		return Vector2(2, 0)
	elif direction == MOVE_NORTHEAST:
		return Vector2(2, -1)
	elif direction == MOVE_NORTHWEST:
		return Vector2(-2, -1)
	elif direction == MOVE_SOUTHEAST:
		return Vector2(2, 1)
	elif direction == MOVE_SOUTHWEST:
		return Vector2(-2, 1)
	else:
		return Vector2()

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
