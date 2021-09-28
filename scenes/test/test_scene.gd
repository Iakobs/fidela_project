extends Spatial

signal test_finished

var get_apple = funcref(FruitFactory, "get_apple")
var get_pear = funcref(FruitFactory, "get_pear")
var get_pineapple = funcref(FruitFactory, "get_pineapple")
var get_banana = funcref(FruitFactory, "get_banana")

onready var touch_area = $TouchArea
onready var fidela = $Fidela
onready var gui = $"3DGui"

func _enter_tree():
	add_to_group(EventBus.CONSUMER_GROUP)

func _ready():
	touch_area.setup(TouchAreaProps.new(
		self,
		fidela.get_horn_slots(Global.HORNS.LEFT),
		fidela.get_horn_slots(Global.HORNS.RIGHT)
	))
	
#	test_drag_drop()
#	test()

func _subscriptions() -> Array:
	return [
		EventBusSubscription.new(
			EventNamespaces.FruitButtons.BUTTON_PRESSED_EVENT,
			"_on_fruit_button_pressed"
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

func add_fruit(fruit: FuncRef, horn: int):
	touch_area.add_fruit(fruit.call_func(), horn)

func remove_fruit(horn: int):
	touch_area.remove_fruit(horn)
	
func test_drag_drop():
	add_fruit(get_apple, Global.HORNS.LEFT)
	add_fruit(get_banana, Global.HORNS.LEFT)
	add_fruit(get_pineapple, Global.HORNS.LEFT)
	
	add_fruit(get_pear, Global.HORNS.RIGHT)
	add_fruit(get_pear, Global.HORNS.RIGHT)
	add_fruit(get_apple, Global.HORNS.RIGHT)

func test():
	should_not_fail_when_adding_and_removing_more_fruits_than_allowed(Global.HORNS.LEFT)
	yield(self, "test_finished")
	should_add_and_remove_one_fruit(Global.HORNS.RIGHT)
	yield(self, "test_finished")
	should_add_and_remove_fruits_in_order(Global.HORNS.RIGHT)
	yield(self, "test_finished")

func should_not_fail_when_adding_and_removing_more_fruits_than_allowed(horn: int):
	add_fruit(get_apple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(get_pear, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(get_pineapple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(get_banana, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")

	emit_signal("test_finished")

func should_add_and_remove_one_fruit(horn: int):
	add_fruit(get_apple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")

	emit_signal("test_finished")

func should_add_and_remove_fruits_in_order(horn: int):
	add_fruit(get_pineapple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(get_pear, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(get_banana, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")

	emit_signal("test_finished")
