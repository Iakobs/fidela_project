extends Node

onready var drag_drop_controller = $DragDropController
onready var left_horn = $LeftHornTouchArea
onready var right_horn = $RightHornTouchArea
onready var customer = $CustomerTouchArea

func setup(props: TouchAreaProps):
	left_horn.setup(
		props.left_horn_slots,
		props.fruits_parent
	)
	right_horn.setup(
		props.right_horn_slots,
		props.fruits_parent
	)
	customer.wanted_fruits = [FruitFactory.FRUITS.APPLE]
	
	left_horn.connect("input_event", self, "_on_horn_input_event", [left_horn])
	right_horn.connect("input_event", self, "_on_horn_input_event", [right_horn])
	customer.connect("area_entered", self, "_on_customer_entered", [customer])

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
		if is_valid_fruit(area, receiver):
			process_valid_fruit(area)

func is_valid_fruit(fruit: Fruit, _customer: Customer) -> bool:
	for wanted_fruit in _customer.wanted_fruits:
		if wanted_fruit == fruit.fruit_enum:
			return true
	
	return false

func process_valid_fruit(fruit: Fruit):
	drag_drop_controller.drag_stop()
	var horn = fruit.original_horn
	horn.dequeue_fruit()
	fruit.queue_free()
