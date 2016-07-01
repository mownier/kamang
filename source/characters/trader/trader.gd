
extends Area2D

onready var g = get_node("/root/global")

var dialogue

func _ready():
	connect("body_enter", self, "on_trigger_conversation")

func on_trigger_conversation(body):
	if body.get_name() == "hero":
		g.quest_dialogue = dialogue
