
extends Node2D

onready var rnge = get_node("character/range")
onready var magic = get_node("character/magic")
onready var shield = get_node("character/shield")
onready var melee = get_node("character/melee")

var items = {
	"armor": "leather",
	"shield": "shield",
	"melee": "short_sword",
	"range": "short_bow",
	"magic": "wand"
}

func _ready():
	on_left_hand_selected(0)
	on_right_hand_selected(0)

func on_change_item(node1, node2):
	var node_name = ""
	if node1.get_parent().get_name() == "equipped":
		node_name = node1.get_name()
	else:
		node_name = node2.get_name()
	
	var type = get_item_type(node_name)
	var node_path = get_node_path(type)
	var item_name = get_item_name(node_name, type)
	update_animation(node_path, item_name)
	update_item_data(type, item_name)

func get_item_type(node_name):
	var strings = node_name.split("_", false)
	var type = strings[0]
	return type

func get_node_path(type):
	return str("character/", type)

func get_item_name(node_name, type):
	return node_name.replace(str(type, "_"), "")

func update_animation(node_path, animation_name):
	var node = get_node(node_path)
	node.set_animation(animation_name)

func update_item_data(type, item_name):
	items["type"] = item_name

func on_left_hand_selected(id):
	if id == 0:
		shield.set_hidden(false)
		rnge.set_hidden(true)
	elif id == 1:
		shield.set_hidden(true)
		rnge.set_hidden(false)

func on_right_hand_selected(id):
	if id == 0:
		melee.set_hidden(false)
		magic.set_hidden(true)
	elif id == 1:
		melee.set_hidden(true)
		magic.set_hidden(false)
