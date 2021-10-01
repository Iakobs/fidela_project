extends Node

const AppleIcon = preload("res://assets/ui/apple_icon.png")
const PearIcon = preload("res://assets/ui/pear_icon.png")
const PineappleIcon = preload("res://assets/ui/pineapple_icon.png")
const BananaIcon = preload("res://assets/ui/banana_icon.png")

export(float, 1.0, 50.0) var apple_generation_time
export(float, 1.0, 50.0) var pear_generation_time
export(float, 1.0, 50.0) var pineapple_generation_time
export(float, 1.0, 50.0) var banana_generation_time

enum HORNS { LEFT, RIGHT }
enum FRUITS { APPLE, PEAR, PINEAPPLE, BANANA }

func get_generation_time(fruit: int) -> float:
	match fruit:
		FRUITS.APPLE:
			return apple_generation_time
		FRUITS.PEAR:
			return pear_generation_time
		FRUITS.PINEAPPLE:
			return pineapple_generation_time
		FRUITS.BANANA:
			return banana_generation_time
		_:
			return 0.1
