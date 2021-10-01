extends Reference

class_name FruitFactory

const Apple = preload("res://scenes/fruits/Apple.tscn")
const Pear = preload("res://scenes/fruits/Pear.tscn")
const Pineapple = preload("res://scenes/fruits/Pineapple.tscn")
const Banana = preload("res://scenes/fruits/Banana.tscn")

static func get_apple() -> Node:
	return get_fruit(Global.FRUITS.APPLE)

static func get_pear() -> Node:
	return get_fruit(Global.FRUITS.PEAR)

static func get_pineapple() -> Node:
	return get_fruit(Global.FRUITS.PINEAPPLE)

static func get_banana() -> Node:
	return get_fruit(Global.FRUITS.BANANA)

static func get_fruit(fruit: int) -> Node:
	match fruit:
		Global.FRUITS.APPLE:
			return Apple.instance()
		Global.FRUITS.PEAR:
			return Pear.instance()
		Global.FRUITS.PINEAPPLE:
			return Pineapple.instance()
		Global.FRUITS.BANANA:
			return Banana.instance()
		_:
			return null
