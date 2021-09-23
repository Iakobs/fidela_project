extends Reference

const APPLE = preload("res://scenes/fruits/Apple.tscn")
const PEAR = preload("res://scenes/fruits/Pear.tscn")
const PINEAPPLE = preload("res://scenes/fruits/Pineapple.tscn")
const BANANA = preload("res://scenes/fruits/Banana.tscn")

class_name FruitFactory

enum FRUITS {
	APPLE,
	PEAR,
	PINEAPPLE,
	BANANA
}

static func get_apple() -> Node:
	return get_fruit(FRUITS.APPLE)

static func get_pear() -> Node:
	return get_fruit(FRUITS.PEAR)

static func get_pineapple() -> Node:
	return get_fruit(FRUITS.PINEAPPLE)

static func get_banana() -> Node:
	return get_fruit(FRUITS.BANANA)

static func get_fruit(fruit: int) -> Node:
	match fruit:
		FRUITS.APPLE:
			return APPLE.instance()
		FRUITS.PEAR:
			return PEAR.instance()
		FRUITS.PINEAPPLE:
			return PINEAPPLE.instance()
		FRUITS.BANANA:
			return BANANA.instance()
		_:
			return null
