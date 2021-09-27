extends Node

onready var left_horn = $LeftHornTouchArea
onready var right_horn = $RightHornTouchArea

func setup(props: TouchAreaProps):
	left_horn.setup(props.left_horn_slots, props.fruits_parent)
	right_horn.setup(props.right_horn_slots, props.fruits_parent)
	
	left_horn.connect("input_event", self, "_on_left_horn_input_event")
	right_horn.connect("input_event", self, "_on_right_horn_input_event")

func add_fruit(fruit: Node, horn: int):
	match horn:
		Global.HORNS.LEFT:
			left_horn.queue_fruit(fruit)
		Global.HORNS.RIGHT:
			right_horn.queue_fruit(fruit)

func remove_fruit(horn: int):
	match horn:
		Global.HORNS.LEFT:
			left_horn.dequeue_fruit()
		Global.HORNS.RIGHT:
			right_horn.dequeue_fruit()

func _on_left_horn_input_event(camera, event, click_position, 
	click_normal, shape_idx):
	match event.get_class():
		"InputEventScreenTouch":
			if event.is_pressed():
				print("Left horn pressed")

func _on_right_horn_input_event(camera, event, click_position, 
	click_normal, shape_idx):
	match event.get_class():
		"InputEventScreenTouch":
			if event.is_pressed():
				print("Right horn pressed")
