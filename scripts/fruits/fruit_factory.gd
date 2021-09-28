extends Reference

const Apple = preload("res://scenes/fruits/Apple.tscn")
const Pear = preload("res://scenes/fruits/Pear.tscn")
const Pineapple = preload("res://scenes/fruits/Pineapple.tscn")
const Banana = preload("res://scenes/fruits/Banana.tscn")

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
			var fruit_instance = Apple.instance()
			fruit_instance.fruit_enum = FRUITS.APPLE
			return fruit_instance
		FRUITS.PEAR:
			var fruit_instance = Pear.instance()
			fruit_instance.fruit_enum = FRUITS.PEAR
			return fruit_instance
		FRUITS.PINEAPPLE:
			var fruit_instance = Pineapple.instance()
			fruit_instance.fruit_enum = FRUITS.PINEAPPLE
			return fruit_instance
		FRUITS.BANANA:
			var fruit_instance = Banana.instance()
			fruit_instance.fruit_enum = FRUITS.BANANA
			return fruit_instance
		_:
			return null
