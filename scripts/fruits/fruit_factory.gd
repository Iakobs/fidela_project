extends Reference

class_name FruitFactory

const Apple = preload("res://scenes/fruits/Apple.tscn")
const Pear = preload("res://scenes/fruits/Pear.tscn")
const Pineapple = preload("res://scenes/fruits/Pineapple.tscn")
const Banana = preload("res://scenes/fruits/Banana.tscn")

static func get_apple() -> Node:
	return get_fruit(Enums.FRUITS.APPLE)

static func get_pear() -> Node:
	return get_fruit(Enums.FRUITS.PEAR)

static func get_pineapple() -> Node:
	return get_fruit(Enums.FRUITS.PINEAPPLE)

static func get_banana() -> Node:
	return get_fruit(Enums.FRUITS.BANANA)

static func get_fruit(fruit: int) -> Node:
	match fruit:
		Enums.FRUITS.APPLE:
			return Apple.instance()
		Enums.FRUITS.PEAR:
			return Pear.instance()
		Enums.FRUITS.PINEAPPLE:
			return Pineapple.instance()
		Enums.FRUITS.BANANA:
			return Banana.instance()
		_:
			return null
