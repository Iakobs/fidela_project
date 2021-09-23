extends Reference

class_name Queue

var slots: Array
var queue: Array

func _init(_slots: Array):
	slots = _slots

func queue() -> RemoteTransform:
	if (queue.size() == slots.size()):
		return null
	
	var remote_transform = slots.pop_front()
	slots.push_back(remote_transform)
	queue.push_back(remote_transform)
	
	return remote_transform

func dequeue() -> String:
	if queue.empty():
		return ""
	
	var remote_transform = queue.pop_front()
	var removed_node_path = remote_transform.remote_path
	
	var remote_paths = []
	for element in queue:
		if element.remote_path:
			remote_paths.push_back(element.remote_path)
	
	var slot_to_remove_remote = slots.pop_back()
	slots.push_front(slot_to_remove_remote)
	
	var slice_start_index
	for i in slots.size():
		var element = slots[i]
		if element.remote_path == removed_node_path:
			slice_start_index = i
			break
	slot_to_remove_remote.remote_path = ""
	
	var sliced_slots = slots.slice(slice_start_index, slots.size())
	
	for i in queue.size():
		var element = sliced_slots[i]
		var new_path = remote_paths[i]
		element.remote_path = new_path
		queue[i] = element
	
	return removed_node_path
