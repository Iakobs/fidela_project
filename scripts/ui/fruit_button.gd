extends TextureButton

export(FruitFactory.FRUITS) var fruit: int

var horn: int setget set_horn

func _ready():
	connect("button_up", self, "_on_button_up")

func set_horn(_horn: int):
	horn = _horn

func _on_button_up():
	print("Publishing event %s" % 
		[EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT]
	)
	EventBus.publish(
		EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT,
		{"fruit": fruit, "horn": horn}
	)

