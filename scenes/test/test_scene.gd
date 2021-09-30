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
			EventNamespaces.FruitButtonsEvents.BUTTON_PRESSED_EVENT,
			"_on_fruit_button_pressed"
		),
		EventBusSubscription.new(
			EventNamespaces.CustomerEvents.CUSTOMER_LEFT_EVENT,
			"_on_customer_left"
		)
	]

func _on_fruit_button_pressed(payload: Dictionary):
	var fruit = payload.fruit
	var horn = payload.horn
	var fruit_ref
	match fruit:
		FruitFactory.FRUITS.APPLE:
			fruit_ref = get_apple
		FruitFactory.FRUITS.PEAR:
			fruit_ref = get_pear
		FruitFactory.FRUITS.PINEAPPLE:
			fruit_ref = get_pineapple
		FruitFactory.FRUITS.BANANA:
			fruit_ref = get_banana
	add_fruit(fruit_ref, horn)

func _on_customer_left(payload: Dictionary):
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/ui/menus/LevelCompletedScreen.tscn")

func add_fruit(fruit: FuncRef, horn: int):
	touch_area.add_fruit(fruit.call_func(), horn)

func remove_fruit(horn: int):
	touch_area.remove_fruit(horn)

