extends Spatial

export(Global.HORNS) var horn: int

onready var balloon = $Balloon
onready var hourglass = $HourglassHolder/Hourglass
onready var timer = $Timer

func _ready():
	hourglass.visible = false
	timer.connect("timeout", self, "_on_timer_timeout")

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

		hourglass.visible = true
		balloon.translation.z *= -1
		balloon.opacity = 0.5
#		timer.wait_time = fruit.generation_time
#		timer.start()
		yield(get_tree().create_timer(generation_time), "timeout")
		hourglass.visible = false
		balloon.translation.z *= -1
		balloon.opacity = 1
		EventBus.publish(
			EventNamespaces.FruitEvents.GENERATION_END_EVENT,
			{ "fruit": fruit, "horn": horn }
		)

func _on_timer_timeout():
	hourglass.visible = false
	balloon.translation.z *= -1
	balloon.opacity = 1
	timer.stop()
