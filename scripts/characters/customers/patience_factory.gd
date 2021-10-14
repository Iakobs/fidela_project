extends Reference

class_name PatienceFactory

var mercy_time = 5.0
var patience_level_factor: Dictionary = {
	"easy" : 1.66,
	"medium" : 1.1,
	"hard" : 0.9
}

func get_patience(fruit: int, amount: int) -> float:
	var generation_time
	match fruit:
		Enums.FRUITS.APPLE:
			generation_time = Global.apple_generation_time
		Enums.FRUITS.PEAR:
			generation_time = Global.pear_generation_time
		Enums.FRUITS.PINEAPPLE:
			generation_time = Global.pineapple_generation_time
		Enums.FRUITS.BANANA:
			generation_time = Global.banana_generation_time
	
	var minimum_required_patience = generation_time * amount
	return minimum_required_patience * mercy_time * patience_level_factor.easy
