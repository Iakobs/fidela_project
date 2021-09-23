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

func add_fruit(fruit: Node):
		var remote_transform = slots.left_slots.queue()
		if remote_transform:
			add_child(fruit)
			remote_transform.remote_path = fruit.get_path()

func remove_fruit():
	var dequeued = slots.left_slots.dequeue()
	if dequeued:
		remove_child(get_node(dequeued))

func test():
	should_not_fail_when_adding_more_fruits_than_allowed()
	yield(self, "test_finished")
	should_not_fail_when_removing_more_fruits_than_allowed()
	yield(self, "test_finished")
	should_add_and_remove_one_fruit()
	yield(self, "test_finished")
	should_add_and_remove_fruits_in_order()

func should_not_fail_when_adding_more_fruits_than_allowed():
	add_fruit(apple)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pear)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pineapple)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(banana)
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")

func should_not_fail_when_removing_more_fruits_than_allowed():
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")

func should_add_and_remove_one_fruit():
	add_fruit(apple)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")

func should_add_and_remove_fruits_in_order():
	add_fruit(pineapple)
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(pear)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	add_fruit(banana)
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	remove_fruit()
	yield(get_tree().create_timer(1.0), "timeout")
	
	emit_signal("test_finished")
