extends Spatial

signal test_finished

var apple = FruitFactory.get_apple()
var pear = FruitFactory.get_pear()
var pineapple = FruitFactory.get_pineapple()
var banana = FruitFactory.get_banana()

var slots = {
	"left_slots": [],
	"right_slots": []
}

onready var fidela = $Fidela

func _ready():
	slots.left_slots = Queue.new(fidela.get_slots(Global.HORNS.LEFT))
	slots.right_slots = Queue.new(fidela.get_slots(Global.HORNS.RIGHT))
	
	test()

func add_fruit(fruit: Node, horn: String):
		var remote_transform = slots[horn].queue()
		if remote_transform:
			add_child(fruit)
			remote_transform.remote_path = fruit.get_path()

func remove_fruit(horn: String):
	var dequeued = slots[horn].dequeue()
	if dequeued:
		remove_child(get_node(dequeued))

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
