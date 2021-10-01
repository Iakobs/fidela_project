extends Node

onready var drag_drop_controller = $DragDropController
onready var left_horn = $LeftHornTouchArea
onready var right_horn = $RightHornTouchArea
onready var customer = $Customer

func setup(props: TouchAreaProps):
	left_horn.setup(
		props.left_horn_slots,
		props.fruits_parent
	)
	right_horn.setup(
		props.right_horn_slots,
		props.fruits_parent
	)
	customer.set_wanted_fruit(WantedFruit.new(Global.FRUITS.APPLE, 3))
	
	left_horn.connect("input_event", self, "_on_horn_input_event", [left_horn])
	right_horn.connect("input_event", self, "_on_horn_input_event", [right_horn])
	customer.connect("area_entered", self, "_on_customer_entered", [customer])

func can_add_fruit(horn: int) -> bool:
	match horn:
		Global.HORNS.LEFT:
			return not left_horn.is_horn_full()
		Global.HORNS.RIGHT:
			return not right_horn.is_horn_full()
		_:
			return false

func add_fruit(fruit: Fruit, horn: int):
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

func _on_horn_input_event(_camera, event, _click_position, 
	_click_normal, _shape_idx, horn: HornTouchArea):
	if event is InputEventScreenTouch and event.is_pressed():
		var fruit_to_drag = horn.get_fruit_to_drag()
		if fruit_to_drag:
			drag_drop_controller.drag_start(fruit_to_drag)

func _on_customer_entered(area: Area, receiver: Area):
	if area is Fruit and receiver is Customer:
		remove_delivered_fruit(area)
		receiver.feed(area.fruit_enum)

func remove_delivered_fruit(fruit: Fruit):
	var horn = fruit.original_horn
	drag_drop_controller.drag_stop()
	horn.dequeue_fruit()
	fruit.queue_free()
