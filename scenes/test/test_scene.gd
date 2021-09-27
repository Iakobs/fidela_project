extends Spatial

signal test_finished

var apple = FruitFactory.get_apple()
var pear = FruitFactory.get_pear()
var pineapple = FruitFactory.get_pineapple()
var banana = FruitFactory.get_banana()

onready var touch_area = $TouchArea
onready var fidela = $Fidela

func _ready():
	touch_area.setup(TouchAreaProps.new(
		self,
		fidela.get_horn_slots(Global.HORNS.LEFT),
		fidela.get_horn_slots(Global.HORNS.RIGHT)
	))
	
#	test()

func add_fruit(fruit: Node, horn: int):
	touch_area.add_fruit(fruit, horn)

func remove_fruit(horn: int):
	touch_area.remove_fruit(horn)

func test():
	should_not_fail_when_adding_and_removing_more_fruits_than_allowed(Global.HORNS.LEFT)
	yield(self, "test_finished")
	should_add_and_remove_one_fruit(Global.HORNS.RIGHT)
	yield(self, "test_finished")
	should_add_and_remove_fruits_in_order(Global.HORNS.RIGHT)
	yield(self, "test_finished")

func should_not_fail_when_adding_and_removing_more_fruits_than_allowed(horn: int):
	add_fruit(apple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pear, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pineapple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(banana, horn)
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
	add_fruit(apple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")

func should_add_and_remove_fruits_in_order(horn: int):
	add_fruit(pineapple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pear, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(banana, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")
