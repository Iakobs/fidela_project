extends Area

class_name HornTouchArea

var slots: HornSlots
var queue: Array
var fruit_parent: Node

func setup(_slots: HornSlots, _fruit_parent: Node):
	slots = _slots
	fruit_parent = _fruit_parent

func queue(fruit: Node):
	if (queue.size() == slots.size()):
		return
	
	var remote_transform = slots.next_slot()
	queue.push_back(remote_transform)
	
	fruit_parent.add_child(fruit)
	remote_transform.remote_path = fruit.get_path()

func dequeue():
	if queue.empty():
		return
	
	fruit_parent.remove_child(fruit_parent.get_node(queue[0].remote_path))
	
	var remote_paths = []
	for remote_reference in queue.slice(1, queue.size()):
		remote_paths.append(remote_reference.remote_path)
	
	for i in remote_paths.size():
		var new_path = remote_paths[i]
		var remote_reference = queue[i]
		remote_reference.remote_path = new_path
	
	queue.pop_back()
	slots.free_slot()
