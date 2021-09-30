tool
extends Node

class_name EventConsumerInterface

func _ready():
	EventBus.add_listener(get_parent())

func _exit_tree():
	EventBus.remove_listener(get_parent())

func _get_configuration_warning():
	if not get_parent().has_method("subscriptions"):
		return """Parent node must implement method subscriptions that returns
		a list of EventBusSubscription"""
	
	return ""
