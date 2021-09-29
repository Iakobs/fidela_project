extends Area

export(FruitFactory.FRUITS) var fruit: int
export(Global.HORNS) var horn: int setget set_horn

func _ready():
	connect("input_event", self, "_on_input_event")

func set_horn(_horn: int):
	horn = _horn

func _on_input_event(
	_camera,
	event,
	_click_position,
	_click_normal,
	_shape_idx
):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Publishing event %s" % 
			[EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT]
		)
		EventBus.publish(
			EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT,
			{"fruit": fruit, "horn": horn}
		)

