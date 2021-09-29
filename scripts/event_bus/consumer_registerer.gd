extends Node

class_name EventConsumerInterface

func _ready():
	EventBus._add_listener(get_parent())
