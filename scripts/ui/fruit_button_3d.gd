extends Area

const SCALING_ON_CLICKING_FACTOR: float = 0.9
const BUTTON_PRESSED_TWEEN_TIME: float = 0.01

export(Global.FRUITS) var fruit: int
export(Global.HORNS) var horn: int
export(float, 0, 10) var generation_time: float

onready var tween = $Tween

var original_scale: Vector3

func _ready():
	original_scale = scale
	connect("input_event", self, "_on_input_event")

func _on_input_event(
	_camera,
	event,
	_click_position,
	_click_normal,
	_shape_idx
):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			on_button_pressed()
		else:
			on_button_released()

func on_button_pressed():
	tween.interpolate_property(
		self,
		"scale",
		original_scale,
		original_scale * SCALING_ON_CLICKING_FACTOR,
		BUTTON_PRESSED_TWEEN_TIME
	)
	tween.start()

func on_button_released():
	tween.interpolate_property(
		self,
		"scale",
		original_scale  * SCALING_ON_CLICKING_FACTOR,
		original_scale,
		BUTTON_PRESSED_TWEEN_TIME
	)
	tween.start()
	EventBus.publish(
		EventNamespaces.FruitEvents.BUTTON_PRESSED_EVENT,
		{"fruit": fruit, "horn": horn}
	)
