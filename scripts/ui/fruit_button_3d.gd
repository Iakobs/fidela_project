extends Area

export(FruitFactory.FRUITS) var fruit: int
export(Global.HORNS) var horn: int setget set_horn

func _ready():
	connect("input_event", self, "_on_input_event")

func set_horn(_horn: int):
	horn = _horn

func _on_input_event(
	camera,
	event,
	click_position,
	click_normal,
	shape_idx
):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Publishing event %s" % 
			[EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT]
		)
		EventBus.publish(
			EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT,
			{"fruit": fruit, "horn": horn}
		)

