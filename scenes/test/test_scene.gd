extends Spatial

signal test_finished

var apple = FruitFactory.get_apple()
var pear = FruitFactory.get_pear()
var pineapple = FruitFactory.get_pineapple()
var banana = FruitFactory.get_banana()

onready var left_horn_touch_area = $LeftHornTouchArea
onready var right_horn_touch_area = $RightHornTouchArea

var slots = {
	"left_slots": HornTouchArea,
	"right_slots": HornTouchArea
}

onready var fidela = $Fidela

func _ready():
	left_horn_touch_area.setup(fidela.get_horn_slots(Global.HORNS.LEFT), self)
	right_horn_touch_area.setup(fidela.get_horn_slots(Global.HORNS.RIGHT), self)
	
	slots.left_slots = left_horn_touch_area
	slots.right_slots = right_horn_touch_area
	
	test()

func add_fruit(fruit: Node, horn: String):
		slots[horn].queue_fruit(fruit)

func remove_fruit(horn: String):
	slots[horn].dequeue_fruit()

func test():
	should_not_fail_when_adding_and_removing_more_fruits_than_allowed("left_slots")
	yield(self, "test_finished")
	should_add_and_remove_one_fruit("right_slots")
	yield(self, "test_finished")
	should_add_and_remove_fruits_in_order("right_slots")
	yield(self, "test_finished")

func should_not_fail_when_adding_and_removing_more_fruits_than_allowed(horn: String):
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

func should_add_and_remove_one_fruit(horn: String):
	add_fruit(apple, horn)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit(horn)
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")

func should_add_and_remove_fruits_in_order(horn: String):
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
