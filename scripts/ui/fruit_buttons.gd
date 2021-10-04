extends Spatial

const ProgressBar = preload("res://scripts/ui/misc/progress_bar.gd")

export(Enums.HORNS) var horn: int
export(int, "NORMAL", "FLIPPED") var mode: int

onready var balloon = $Balloon
onready var progress_bar = $ProgressBarHolder/ProgressBar3D
onready var buttons = $Buttons

func _ready():
	if mode == 1:
		balloon.flip_v = true
	
	progress_bar.visible = false
	
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
	var pressed_horn = payload.horn
	if pressed_horn == horn:
		var fruit = payload.fruit
		var generation_time = Global.get_generation_time(fruit)

		disable_during_generation(generation_time)
		yield(get_tree().create_timer(generation_time), "timeout")
		enable()
		EventBus.publish(
			EventNamespaces.FruitEvents.GENERATION_END_EVENT,
			{ "fruit": fruit, "horn": horn }
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
