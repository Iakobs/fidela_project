extends Node

class_name HornSlots

var slots: Array

func _ready():
	for child in get_children():
		if child is RemoteTransform:
			slots.push_back(child)

func next_slot() -> RemoteTransform:
	var remote_transform = slots.pop_front()
	slots.push_back(remote_transform)
	
	return remote_transform

func free_slot():
	var freed_slot = slots.pop_back()
	slots.push_front(freed_slot)

func size() -> int:
	return slots.size()
