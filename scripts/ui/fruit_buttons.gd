extends Spatial

const ProgressBar = preload("res://scripts/ui/misc/progress_bar.gd")

export(Enums.HORNS) var horn: int
export(int, "NORMAL", "FLIPPED") var mode: int

onready var balloon = $Balloon
onready var progress_bar = $ProgressBarHolder/ProgressBar3D
onready var buttons = $Buttons

var pressed_fruit: int

func _ready():
	if mode == 1:
		balloon.flip_v = true
	
	progress_bar.visible = false
	progress_bar.connect("progress_completed", self, "_on_progress_completed")
	
	for child in buttons.get_children():
		child.horn = horn

func subscriptions() -> Array:
	return [
		EventBusSubscription.new(
			EventNamespaces.FruitEvents.GENERATION_START_EVENT,
			"_on_fruit_generation_start"
		)
	]

func _on_fruit_generation_start(payload: Dictionary):
	pressed_fruit = payload.fruit
	var pressed_horn = payload.horn
	if pressed_horn == horn:
		var generation_time = Global.get_generation_time(pressed_fruit)
		disable_during_generation(generation_time)

func _on_progress_completed():
	enable()
	EventBus.publish(
		EventNamespaces.FruitEvents.GENERATION_END_EVENT,
		{ "fruit": pressed_fruit, "horn": horn }
	)

func disable_during_generation(dutation: float):
	progress_bar.visible = true
	progress_bar.start(dutation)
	balloon.translation.z *= -1
	balloon.opacity = 0.5

func enable():
	progress_bar.visible = false
	balloon.translation.z *= -1
	balloon.opacity = 1
