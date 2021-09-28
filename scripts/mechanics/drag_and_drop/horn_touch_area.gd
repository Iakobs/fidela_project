extends Area

class_name HornTouchArea

var slots: HornSlots
var fruit_queue: Array
var fruit_parent: Node

func setup(_slots: HornSlots, _fruit_parent: Node):
	slots = _slots
	fruit_parent = _fruit_parent

func get_fruit_to_drag() -> Fruit:
	if not fruit_queue.empty():
		var path_to_fruit = fruit_queue[0].remote_path
		var fruit = fruit_parent.get_node(path_to_fruit)
		fruit.set_original_horn(self)
		fruit.set_original_position(fruit.transform.origin)
		return fruit
	
	return null

func queue_fruit(fruit: Fruit):
	if (fruit_queue.size() == slots.size()):
		return
	
	var remote_transform = slots.next_slot()
	fruit_queue.push_back(remote_transform)
	
	fruit_parent.add_child(fruit)
	remote_transform.remote_path = fruit.get_path()

func dequeue_fruit():
	if fruit_queue.empty():
		return
	
	var fruit_to_be_removed = fruit_parent.get_node(fruit_queue[0].remote_path)
	fruit_parent.remove_child(fruit_to_be_removed)
	
	var remote_paths = []
	for remote_reference in fruit_queue.slice(1, fruit_queue.size()):
		remote_paths.append(remote_reference.remote_path)
	
	for i in remote_paths.size():
		var new_path = remote_paths[i]
		var remote_reference = fruit_queue[i]
		remote_reference.remote_path = new_path
	
	var dequeued_fruit = fruit_queue.pop_back()
	dequeued_fruit.remote_path = ""
	slots.free_slot()
