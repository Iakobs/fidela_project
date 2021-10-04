extends Node

const AppleIcon = preload("res://assets/ui/apple_icon.png")
const PearIcon = preload("res://assets/ui/pear_icon.png")
const PineappleIcon = preload("res://assets/ui/pineapple_icon.png")
const BananaIcon = preload("res://assets/ui/banana_icon.png")

export(float, 1.0, 50.0, 0.5) var apple_generation_time = 1.0
export(float, 1.0, 50.0, 0.5) var pear_generation_time = 2.0
export(float, 1.0, 50.0, 0.5) var pineapple_generation_time = 3.0
export(float, 1.0, 50.0, 0.5) var banana_generation_time = 4.0

func get_generation_time(fruit: int) -> float:
	match fruit:
		Enums.FRUITS.APPLE:
			return apple_generation_time
		Enums.FRUITS.PEAR:
			return pear_generation_time
		Enums.FRUITS.PINEAPPLE:
			return pineapple_generation_time
		Enums.FRUITS.BANANA:
			return banana_generation_time
		_:
			return 0.1
