
extends StaticBody2D

export var type = 0

onready var sprite = get_node("sprite")


func _ready():
	if type == 0:
		sprite.set_region_rect(Rect2(128, 992, 128, 128))
	else:
		sprite.set_region_rect(Rect2(0, 0, 0, 0))


