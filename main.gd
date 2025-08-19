extends Node

var dialogue_resource: DialogueResource

func _ready() -> void:
	dialogue_resource = load("res://dialog/intro.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
