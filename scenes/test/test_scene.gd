extends Spatial

var get_apple = funcref(FruitFactory, "get_apple")
var get_pear = funcref(FruitFactory, "get_pear")
var get_pineapple = funcref(FruitFactory, "get_pineapple")
var get_banana = funcref(FruitFactory, "get_banana")

onready var touch_area = $TouchArea
onready var fidela = $Fidela

func _ready():
	touch_area.setup(TouchAreaProps.new(
		self,
		fidela.get_horn_slots(Global.HORNS.LEFT),
		fidela.get_horn_slots(Global.HORNS.RIGHT)
	))

func subscriptions() -> Array:
	return [
		EventBusSubscription.new(
			EventNamespaces.FruitEvents.BUTTON_PRESSED_EVENT,
			"_on_fruit_button_pressed"
		),
		EventBusSubscription.new(
			EventNamespaces.FruitEvents.GENERATION_END_EVENT,
			"_on_fruit_generation_end"
		),
		EventBusSubscription.new(
			EventNamespaces.CustomerEvents.CUSTOMER_LEFT_EVENT,
			"_on_customer_left"
		)
	]

func _on_fruit_button_pressed(payload: Dictionary):
	if touch_area.can_add_fruit(payload.horn):
		EventBus.publish(
			EventNamespaces.FruitEvents.GENERATION_START_EVENT,
			{ "fruit": payload.fruit, "horn": payload.horn}
		)

func _on_fruit_generation_end(payload: Dictionary):
	var fruit = payload.fruit
	var horn = payload.horn
	var fruit_ref
	match fruit:
		Global.FRUITS.APPLE:
			fruit_ref = get_apple
		Global.FRUITS.PEAR:
			fruit_ref = get_pear
		Global.FRUITS.PINEAPPLE:
			fruit_ref = get_pineapple
		Global.FRUITS.BANANA:
			fruit_ref = get_banana
	add_fruit(fruit_ref, horn)

func _on_customer_left(_payload: Dictionary):
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/ui/menus/LevelCompletedScreen.tscn")

func add_fruit(fruit: FuncRef, horn: int):
	touch_area.add_fruit(fruit.call_func(), horn)

func remove_fruit(horn: int):
	touch_area.remove_fruit(horn)

