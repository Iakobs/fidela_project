extends Node

class_name EventConsumerInterface

func _ready():
	EventBus.add_listener(get_parent())

func _exit_tree():
	EventBus.remove_listener(get_parent())
